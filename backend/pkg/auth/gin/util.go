package gin

import (
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/alexmeuer/secret-santa-list/pkg/auth"
	"github.com/gin-gonic/gin"
	"github.com/mitchellh/mapstructure"
	"github.com/rs/zerolog/log"
)

const (
	TknDetailKey          = "tkn_detail"
	HasuraClaimsNamespace = "https://hasura.io/jwt/claims"
)

type TokenGetter interface {
	Get(ID string) (string, error)
}

type HasuraClaims struct {
	AllowedRoles []string `structs:"x-hasura-allowed-roles" mapstructure:"x-hasura-allowed-roles"`
	DefaultRole  string   `structs:"x-hasura-default-role" mapstructure:"x-hasura-default-role"`
	UserID       string   `structs:"x-hasura-user-id" mapstructure:"x-hasura-user-id"`
}

type HasuraResponse struct {
	UserID  string `json:"x-hasura-user-id,omitempty"`
	Role    string `json:"x-hasura-role"`
	Expires string `json:"expires,omitempty"`
}

// https://datatracker.ietf.org/doc/html/rfc6750#section-3
type WWWAuthenticateChallenge struct {
	Type      string
	Realm     string
	Scope     string
	Error     string
	ErrorDesc string
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

func ReadTknDetail(ctx *gin.Context) (*auth.InboundTokenDetails, error) {
	val, exists := ctx.Get(TknDetailKey)
	if !exists {
		return nil, fmt.Errorf("%s not found in Context", TknDetailKey)
	}
	tknDetail, ok := val.(*auth.InboundTokenDetails)
	if !ok {
		return nil, fmt.Errorf("%s in Context is not an (*InboundTokenDetails)", TknDetailKey)
	}
	return tknDetail, nil
}

func Middleware(JWTMgr *auth.JWTManager, store TokenGetter, reqKeyID string, allowNoAuth bool) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		authHeader := strings.Fields(ctx.Request.Header.Get("Authorization"))
		chal := WWWAuthenticateChallenge{
			Type: "Bearer",
		}
		if len(authHeader) == 0 {
			if allowNoAuth {
				ctx.JSON(http.StatusOK, HasuraResponse{
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
		tknDetail, err := auth.ExtractDetail(tkn, reqKeyID)
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

func HasuraEndpoint(ctx *gin.Context) {
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

	var response HasuraResponse

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
}
