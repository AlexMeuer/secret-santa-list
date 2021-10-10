package gqlact

import (
	"fmt"
	"net/http"

	httpx "github.com/alexmeuer/http"
	"github.com/gin-contrib/logger"
	"github.com/gin-gonic/gin"
	"github.com/hasura/go-graphql-client"
	"github.com/rs/zerolog/log"
)

func Serve(port int16, hasuraEndpoint, hasuraSecret string) error {
	log.Debug().Msgf("GraphQL endpoint is %s", hasuraEndpoint)

	c := &controller{
		GQL: graphql.NewClient(hasuraEndpoint, &http.Client{
			Transport: &httpx.CustomHeaderTransport{
				Headers: map[string]string{
					"X-Hasura-Admin-Secret": hasuraSecret,
				},
			},
		}),
	}
	r := gin.Default()
	r.Use(logger.SetLogger())
	r.POST("/room/join", c.CreateOrJoinRoom)

	return r.Run(fmt.Sprintf("0.0.0.0:%d", port))
}
