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
)

type TokenStore interface {
	Write(userID string, td *TokenDetails) error
}

type PasswordChecker interface {
	Check(ctx context.Context, name, password string) error
}

type BasicAuthInfo struct {
	Name     string
	Password string
}

func Serve(port int16, tknCreator *JWTCreator, tknStore TokenStore, pwChecker PasswordChecker) error {
	r := gin.Default()

	r.POST("/login", func(ctx *gin.Context) {
		authInfo, err := decodeBasicAuth(ctx)
		if err != nil {
			return
		}
		if err = pwChecker.Check(ctx, authInfo.Name, authInfo.Password); err != nil {
			ctx.String(http.StatusForbidden, "Incorrect name/password combination.")
			return
		}
		claims := map[string]jwt.MapClaims{
			"https://hasura.io/jwt/claims": {
				"x-hasura-allowed-roles": []string{"anon", "user"},
				"x-hasura-default-role":  "user",
				"x-hasura-user-id":       authInfo.Name,
			},
		}
		td, err := tknCreator.CreateToken(authInfo.Name, claims)
		if err != nil {
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		if err = tknStore.Write(authInfo.Name, td); err != nil {
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		ctx.JSON(http.StatusOK, td.AccessToken)
	})

	return r.Run(fmt.Sprintf("0.0.0.0:%d", port))
}

func decodeBasicAuth(ctx *gin.Context) (*BasicAuthInfo, error) {
	authHeader := ctx.Request.Header.Get("Authorization")
	if authHeader == "" {
		ctx.Header("WWW-Authenticate", "Basic")
		ctx.Status(http.StatusUnauthorized)
		return nil, errors.New("no authorization provided")
	}
	fields := strings.Fields(authHeader)
	if len(fields) != 2 {
		err := errors.New("invalid authorization header format")
		ctx.String(http.StatusBadRequest, err.Error())
		return nil, err
	}
	b, err := base64.StdEncoding.DecodeString(fields[1])
	if err != nil {
		ctx.Header("WWW-Authenticate", "Basic")
		ctx.String(http.StatusUnauthorized, err.Error())
		return nil, err
	}
	split := strings.Split(string(b), ":")
	return &BasicAuthInfo{
		Name:     split[0],
		Password: split[1],
	}, nil
}
