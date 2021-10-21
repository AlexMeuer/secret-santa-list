package auth

import (
	"context"
	"encoding/base64"
	"errors"
	"fmt"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
	"github.com/rs/zerolog/log"
	"golang.org/x/crypto/bcrypt"
)

const TknDetailKey = "tkn_detail"

type TokenStore interface {
	Set(userID string, td *OutboundTokenDetails) error
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
		claims := map[string]jwt.MapClaims{
			"https://hasura.io/jwt/claims": {
				"x-hasura-allowed-roles": []string{"anon", "user"},
				"x-hasura-default-role":  "user",
				"x-hasura-user-id":       authInfo.Name,
			},
		}
		td, err := JWTMgr.Create(authInfo.Name, claims)
		if err != nil {
			log.Err(err).Str("user", authInfo.Name).Msg("Failed to create token.")
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		if err = tknStore.Set(authInfo.Name, td); err != nil {
			log.Err(err).Str("user", authInfo.Name).Msg("Failed to write token to store.")
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		ctx.JSON(http.StatusOK, td)
	})

	r.POST("/deauth", TokenAuthMiddleware(JWTMgr, "a"), func(ctx *gin.Context) {
		tknDetails, err := ReadTknDetail(ctx)
		if err != nil {
			log.Err(err).Msg("Token details not found!")
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		if err := tknStore.Del(tknDetails.UUID); err != nil {
			log.Err(err).Msg("Failed to deauthorize token!")
			ctx.String(http.StatusInternalServerError, "failed to deauthorize token")
			return
		}
		ctx.Status(http.StatusAccepted)
	})

	r.POST("/refresh", TokenAuthMiddleware(JWTMgr, "r"), func(ctx *gin.Context) {
		ctx.Status(http.StatusNotImplemented) // TODO
	})

	return r.Run(fmt.Sprintf("0.0.0.0:%d", port))
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

func TokenAuthMiddleware(JWTMgr *JWTManager, reqKeyID string) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		authHeader := strings.Fields(ctx.Request.Header.Get("Authorization"))
		chal := WWWAuthenticateChallenge{
			Type: "Bearer",
		}
		if len(authHeader) == 0 {
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.Status(http.StatusUnauthorized)
			return
		}
		if len(authHeader) != 2 {
			chal.Error = "invalid_token"
			chal.ErrorDesc = "malformed authorization header"
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.String(http.StatusUnauthorized, "malformed authorization header")
			return
		}
		tkn, err := JWTMgr.Verify(authHeader[1])
		if err != nil {
			chal.Error = "invalid_token"
			chal.ErrorDesc = "failed to verify token"
			ctx.String(http.StatusUnauthorized, "failed to verify token: %s", err.Error())
			return
		}
		if !tkn.Valid {
			chal.Error = "invalid_token"
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.String(http.StatusUnauthorized, "token not valid")
			return
		}
		tknDetail, err := ExtractDetail(tkn, reqKeyID)
		if err != nil {
			chal.Error = "invalid_token"
			chal.ErrorDesc = "failed to extract required info from token"
			ctx.Header("WWW-Authenticate", chal.String())
			ctx.String(http.StatusUnauthorized, "failed to extract info: %s", err.Error())
			return
		}
		ctx.Set(TknDetailKey, tknDetail)
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
