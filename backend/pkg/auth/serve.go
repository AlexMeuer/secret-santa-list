package auth

import (
	"encoding/base64"
	"fmt"
	"net/http"
	"strings"
	"time"

	httpx "github.com/alexmeuer/http"
	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis"
	"github.com/golang-jwt/jwt"
	"github.com/hasura/go-graphql-client"
	"golang.org/x/crypto/bcrypt"
)

type User struct {
	Name     string
	Password string
}

func Serve(port int16, JWTSecret string, hasuraEndpoint, hasuraSecret string, redisClient *redis.Client) error {
	gqlClient := graphql.NewClient(hasuraEndpoint, &http.Client{
		Transport: &httpx.CustomHeaderTransport{
			Headers: map[string]string{
				"X-Hasura-Admin-Secret": hasuraSecret,
			},
		},
	})
	JWT := JWTAuth{
		Secret: JWTSecret,
	}

	r := gin.Default()

	r.POST("/login", func(ctx *gin.Context) {
		authHeader := ctx.Request.Header.Get("Authorization")
		if authHeader == "" {
			ctx.Header("WWW-Authenticate", "Basic")
			ctx.Status(http.StatusUnauthorized)
			return
		}
		b, err := base64.StdEncoding.DecodeString(ctx.Request.Header.Get("Authorization"))
		if err != nil {
			ctx.Header("WWW-Authenticate", "Basic")
			ctx.String(http.StatusUnauthorized, err.Error())
			return
		}
		authData := strings.Split(string(b), ":")
		var q struct {
			User struct {
				Password string
			}
		}
		v := gql.Vars{"name": gql.String(authData[0])}
		if err = gqlClient.NamedQuery(ctx, "UserPWForLogin", &q, v); err != nil {
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		if err = bcrypt.CompareHashAndPassword([]byte(q.User.Password), []byte(authData[1])); err != nil {
			ctx.String(http.StatusForbidden, "Incorrect name/password combination.")
			return
		}
		hasuraClaims := jwt.MapClaims{
			"x-hasura-allowed-roles": []string{"anon", "user"},
			"x-hasura-default-role":  "user",
			"x-hasura-user-id":       authData[0],
			//"x-hasura-org-id":        "123",
			//"x-hasura-custom":        "custom-value",
		}
		tkn, err := JWT.CreateToken(authData[0], WithExpiryIn(60*time.Minute), WithClaims("https://hasura.io/jwt/claims", hasuraClaims))
		if err != nil {
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		ctx.JSON(http.StatusOK, tkn)
		// TODO: https://learn.vonage.com/blog/2020/03/13/using-jwt-for-authentication-in-a-golang-application-dr/
		// TODO: Create package with token store.
	})
	return r.Run(fmt.Sprintf("0.0.0.0:%d", port))
}
