package auth

import (
	"context"
	"encoding/base64"
	"errors"
	"fmt"
	"net/http"
	"strings"

	"github.com/alexmeuer/secret-santa-list/pkg/auth"
	auth_util "github.com/alexmeuer/secret-santa-list/pkg/auth/gin"
	"github.com/fatih/structs"
	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
	"github.com/rs/zerolog/log"
	"golang.org/x/crypto/bcrypt"
)

type TokenStore interface {
	Set(userID string, td *auth.OutboundTokenDetails) error
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

func Serve(port int16, JWTMgr *auth.JWTManager, tknStore TokenStore, pwChecker PasswordChecker) error {
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

	r.POST("/deauth", auth_util.Middleware(JWTMgr, tknStore, "a", false), func(ctx *gin.Context) {
		tknDetails, err := auth_util.ReadTknDetail(ctx)
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

	r.POST("/refresh", auth_util.Middleware(JWTMgr, tknStore, "r", false), func(ctx *gin.Context) {
		tknDetails, err := auth_util.ReadTknDetail(ctx)
		if err != nil {
			log.Err(err).Msg("Token details not found!")
			ctx.AbortWithError(http.StatusInternalServerError, err)
			return
		}
		if tknStore.Del(tknDetails.UUID); err != nil {
			log.Err(err).Str("user", tknDetails.UserID).Str("tkn_id", tknDetails.UUID).Msg("Failed to delete refresh token.")
			chal := auth_util.WWWAuthenticateChallenge{
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

	r.GET("/hasura", auth_util.Middleware(JWTMgr, tknStore, "a", true), auth_util.HasuraEndpoint)

	return r.Run(fmt.Sprintf("0.0.0.0:%d", port))
}

func CreateAndStoreTokenPair(JWTMgr *auth.JWTManager, tknStore TokenStore, userID string) (td *auth.OutboundTokenDetails, err error) {
	claims := map[string]jwt.MapClaims{
		auth_util.HasuraClaimsNamespace: structs.Map(auth_util.HasuraClaims{
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

func decodeBasicAuth(ctx *gin.Context) (*BasicAuthInfo, error) {
	authHeader := ctx.Request.Header.Get("Authorization")
	chal := auth_util.WWWAuthenticateChallenge{
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
