package auth

import (
	"context"
	"encoding/base64"
	"errors"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/fatih/structs"
	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
	"github.com/mitchellh/mapstructure"
	"github.com/rs/zerolog/log"
	"golang.org/x/crypto/bcrypt"
)

const TknDetailKey = "tkn_detail"
const HasuraClaimsNamespace = "https://hasura.io/jwt/claims"

type TokenStore interface {
	Set(userID string, td *OutboundTokenDetails) error
	Get(ID string) (string, error)
	Del(ID string) error
}

type PasswordChecker interface {
	Check(ctx context.Context, name, password string) error
}

type BasicAuthInfo struct {
	Name     string
	Password string
}

// https://datatracker.ietf.org/doc/html/rfc6750#section-3
type WWWAuthenticateChallenge struct {
	Type      string
	Realm     string
	Scope     string
	Error     string
	ErrorDesc string
}

type HasuraClaims struct {
	AllowedRoles []string `structs:"x-hasura-allowed-roles" mapstructure:"x-hasura-allowed-roles"`
	DefaultRole  string   `structs:"x-hasura-default-role" mapstructure:"x-hasura-default-role"`
	UserID       string   `structs:"x-hasura-user-id" mapstructure:"x-hasura-user-id"`
}

type HasuraAuthResponse struct {
	UserID  string `json:"x-hasura-user-id,omitempty"`
	Role    string `json:"x-hasura-role"`
	Expires string `json:"expires,omitempty"`
}

func Serve(port int16, JWTMgr *JWTManager, tknStore TokenStore, pwChecker PasswordChecker) error {
	r := gin.Default()

	r.POST("/auth", func(ctx *gin.Context) {
		authInfo, err := decodeBasicAuth(ctx)
		if err != nil {
			return
		}
		if err = pwChecker.Check(ctx, authInfo.Name, authInfo.Password); err != nil {
			if err == bcrypt.ErrMismatchedHashAndPassword {
				ctx.String(http.StatusForbidden, "Incorrect name/password combination.")
				return
			}
			log.Err(err).Str("user", authInfo.Name).Msg("PW check failed.")
			ctx.String(http.StatusBadRequest, fmt.Sprintf("PW check failed: %s", err.Error()))
			return
		}
		if td, err := CreateAndStoreTokenPair(JWTMgr, tknStore, authInfo.Name); err != nil {
			ctx.Status(http.StatusInternalServerError)
		} else {
			ctx.JSON(http.StatusOK, td)
		}
	})

	r.POST("/deauth", TokenAuthMiddleware(JWTMgr, tknStore, "a", false), func(ctx *gin.Context) {
		tknDetails, err := ReadTknDetail(ctx)
		if err != nil {
			log.Err(err).Msg("Token details not found!")
			ctx.AbortWithError(http.StatusInternalServerError, err)
			return
		}
		if err := tknStore.Del(tknDetails.UUID); err != nil {
			log.Err(err).Msg("Failed to deauthorize token!")
			ctx.AbortWithError(http.StatusInternalServerError, err)
			return
		}
		ctx.Status(http.StatusAccepted)
	})

	r.POST("/refresh", TokenAuthMiddleware(JWTMgr, tknStore, "r", false), func(ctx *gin.Context) {
		tknDetails, err := ReadTknDetail(ctx)
		if err != nil {
			log.Err(err).Msg("Token details not found!")
			ctx.AbortWithError(http.StatusInternalServerError, err)
			return
		}
		if tknStore.Del(tknDetails.UUID); err != nil {
			log.Err(err).Str("user", tknDetails.UserID).Str("tkn_id", tknDetails.UUID).Msg("Failed to delete refresh token.")
			chal := WWWAuthenticateChallenge{
				Type:      "Bearer",
				Error:     "invalid_token",
				ErrorDesc: "token not found",
			}
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.Status(http.StatusUnauthorized)
			return
		}
		if td, err := CreateAndStoreTokenPair(JWTMgr, tknStore, tknDetails.UserID); err != nil {
			ctx.Status(http.StatusInternalServerError)
		} else {
			ctx.JSON(http.StatusOK, td)
		}
	})

	r.GET("/hasura", TokenAuthMiddleware(JWTMgr, tknStore, "a", true), func(ctx *gin.Context) {
		tknDetails, err := ReadTknDetail(ctx)
		if err != nil {
			log.Err(err).Msg("Token details not found!")
			ctx.AbortWithError(http.StatusInternalServerError, err)
			return
		}
		var claims HasuraClaims
		if err = mapstructure.Decode(tknDetails.Claims[HasuraClaimsNamespace], &claims); err != nil {
			log.Err(err).Interface("hasura_claims", tknDetails.Claims[HasuraClaimsNamespace]).Msg("Failed to decode Hasura claims!")
			ctx.Status(http.StatusUnauthorized)
			return
		}

		var response HasuraAuthResponse

		if reqUserID := ctx.Request.Header.Get("X-Hasura-User-Id"); reqUserID != "" {
			if reqUserID != claims.UserID {
				log.Warn().Msgf("Requested user ID (%s) does not match Hasura claim (%s)", reqUserID, claims.UserID)
				ctx.Status(http.StatusUnauthorized)
				return
			}
		} else {
			response.UserID = claims.UserID
		}
		if reqRole := ctx.Request.Header.Get("X-Hasura-Role"); reqRole != "" {
			for _, r := range claims.AllowedRoles {
				if reqRole == r {
					response.Role = reqRole
					break
				}
			}
			if response.Role == "" {
				log.Warn().Msgf("Requested role (%s) does not match Hasura claim (%v)", reqRole, claims.AllowedRoles)
				ctx.Status(http.StatusUnauthorized)
				return
			}
		} else {
			response.Role = claims.DefaultRole
		}

		// TODO: Figure out why the conversion to int64 is failing.
		if exp, ok := tknDetails.Claims["exp"]; ok {
			if expUnix, ok := exp.(int64); ok {
				response.Expires = time.Unix(expUnix, 0).Format(time.RFC3339)
			} else {
				log.Error().Interface("exp", exp).Msg("Token claim 'exp' could not be converted to int64.")
			}
		} else {
			log.Error().Interface("claims", tknDetails.Claims).Msg("'exp' not found in claims.")
		}

		ctx.JSON(http.StatusOK, response)
	})

	return r.Run(fmt.Sprintf("0.0.0.0:%d", port))
}

func CreateAndStoreTokenPair(JWTMgr *JWTManager, tknStore TokenStore, userID string) (td *OutboundTokenDetails, err error) {
	claims := map[string]jwt.MapClaims{
		HasuraClaimsNamespace: structs.Map(HasuraClaims{
			AllowedRoles: []string{"anon", "user"},
			DefaultRole:  "user",
			UserID:       userID,
		}),
	}
	td, err = JWTMgr.Create(userID, claims)
	if err != nil {
		log.Err(err).Str("user", userID).Msg("Failed to create token.")
		return
	}
	if err = tknStore.Set(userID, td); err != nil {
		log.Err(err).Str("user", userID).Msg("Failed to write token to store.")
	}
	return
}

func ReadTknDetail(ctx *gin.Context) (*InboundTokenDetails, error) {
	val, exists := ctx.Get(TknDetailKey)
	if !exists {
		return nil, fmt.Errorf("%s not found in Context", TknDetailKey)
	}
	tknDetail, ok := val.(*InboundTokenDetails)
	if !ok {
		return nil, fmt.Errorf("%s in Context is not an (*InboundTokenDetails)", TknDetailKey)
	}
	return tknDetail, nil
}

func TokenAuthMiddleware(JWTMgr *JWTManager, store TokenStore, reqKeyID string, allowNoAuth bool) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		authHeader := strings.Fields(ctx.Request.Header.Get("Authorization"))
		chal := WWWAuthenticateChallenge{
			Type: "Bearer",
		}
		if len(authHeader) == 0 {
			if allowNoAuth {
				ctx.JSON(http.StatusOK, HasuraAuthResponse{
					Role: "anon",
				})
				ctx.Abort()
			} else {
				ctx.Header("WWW-Authenticate", chal.String())
				ctx.AbortWithStatus(http.StatusUnauthorized)
			}
			return
		}
		if len(authHeader) != 2 {
			chal.Error = "invalid_token"
			chal.ErrorDesc = "malformed authorization header"
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.AbortWithStatus(http.StatusUnauthorized)
			return
		}
		tkn, err := JWTMgr.Verify(authHeader[1])
		if err != nil {
			chal.Error = "invalid_token"
			chal.ErrorDesc = "failed to verify token"
			ctx.AbortWithError(http.StatusUnauthorized, err)
			return
		}
		if !tkn.Valid {
			chal.Error = "invalid_token"
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.AbortWithStatus(http.StatusUnauthorized)
			return
		}
		tknDetail, err := ExtractDetail(tkn, reqKeyID)
		if err != nil {
			chal.Error = "invalid_token"
			chal.ErrorDesc = "failed to extract required info from token"
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.AbortWithError(http.StatusUnauthorized, err)
			return
		}
		if userID, err := store.Get(tknDetail.UUID); err != nil {
			chal.Error = "invalid_token"
			chal.ErrorDesc = "token expired/revoked"
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.AbortWithStatus(http.StatusUnauthorized)
		} else if userID != tknDetail.UserID {
			chal.Error = "invalid_token"
			chal.ErrorDesc = "token/user mismatch"
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.AbortWithStatus(http.StatusUnauthorized)
		} else {
			ctx.Set(TknDetailKey, tknDetail)
			ctx.Next()
		}
	}
}

func decodeBasicAuth(ctx *gin.Context) (*BasicAuthInfo, error) {
	authHeader := ctx.Request.Header.Get("Authorization")
	chal := WWWAuthenticateChallenge{
		Type: "Basic",
	}
	if authHeader == "" {
		ctx.Header("WWW-Authenticate", chal.String())
		ctx.Status(http.StatusUnauthorized)
		return nil, errors.New("no authorization provided")
	}
	fields := strings.Fields(authHeader)
	if len(fields) != 2 {
		chal.Error = "invalid_header"
		chal.ErrorDesc = "invalid authorization header format"
		ctx.Header("WWW-Authenticate", chal.String())
		ctx.Status(http.StatusUnauthorized)
		return nil, errors.New("bad auth header")
	}
	b, err := base64.StdEncoding.DecodeString(fields[1])
	if err != nil {
		chal.Error = "invalid_header"
		chal.ErrorDesc = "failed base64 decode"
		ctx.Header("WWW-Authenticate", chal.String())
		ctx.Status(http.StatusUnauthorized)
		return nil, err
	}
	split := strings.Split(string(b), ":")
	info := &BasicAuthInfo{
		Name: split[0],
	}
	if len(split) > 1 {
		info.Password = split[1]
	}
	return info, nil
}

func (c *WWWAuthenticateChallenge) String() string {
	bldr := strings.Builder{}
	bldr.WriteString(c.Type)
	add := func(k, v string) {
		if v != "" {
			bldr.WriteString(fmt.Sprintf(`, %s="%s"`, k, v))
		}
	}
	add("realm", c.Realm)
	add("scope", c.Scope)
	add("error", c.Error)
	add("error_description", c.ErrorDesc)
	return bldr.String()
}
