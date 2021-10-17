/*
Copyright © 2021 Alexander Meuer <alex@alexmeuer.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/
package cmd

import (
	"net/http"
	"time"

	httpx "github.com/alexmeuer/http"
	"github.com/alexmeuer/secret-santa-list/internal/serve/auth"
	"github.com/go-redis/redis/v7"
	"github.com/google/uuid"
	"github.com/hasura/go-graphql-client"
	"github.com/spf13/cobra"
)

var (
	JWTAccessSecret  string
	JWTRefreshSecret string
	JWTAccessTTL     time.Duration
	JWTRefreshTTL    time.Duration
	RedisAddr        string
	RedisUser        string
	RedisPW          string
)

// authCmd represents the auth command
var authCmd = &cobra.Command{
	Use:   "auth",
	Short: "Starts a RESTful JWT auth server",
	RunE: func(cmd *cobra.Command, args []string) error {
		redisClient := redis.NewClient(&redis.Options{
			Addr:     RedisAddr,
			Username: RedisUser,
			Password: RedisPW,
		})
		if err := redisClient.Ping().Err(); err != nil {
			return err
		}

		tknCreator := &auth.JWTCreator{
			AccessSecret:  []byte(JWTAccessSecret),
			RefreshSecret: []byte(JWTRefreshSecret),
			AccessTTL:     JWTAccessTTL,
			RefreshTTL:    JWTRefreshTTL,
			GenerateUUID:  uuid.NewString,
		}
		tknStore := &auth.RedisTokenStore{Client: redisClient}
		PWChecker := &auth.GraphQLPasswordChecker{
			Client: graphql.NewClient(hasuraEndpoint, &http.Client{
				Transport: &httpx.CustomHeaderTransport{
					Headers: map[string]string{
						"X-Hasura-Admin-Secret": hasuraSecret,
					},
					Base: http.DefaultTransport,
				},
			}),
		}
		return auth.Serve(port, tknCreator, tknStore, PWChecker)
	},
}

func init() {
	serveCmd.AddCommand(authCmd)
	authCmd.PersistentFlags().StringVar(&JWTAccessSecret, "jwt-access-secret", "", "Used to create access tokens.")
	authCmd.PersistentFlags().StringVar(&JWTRefreshSecret, "jwt-refesh-secret", "", "Used to create refresh tokens.")
	authCmd.PersistentFlags().DurationVar(&JWTAccessTTL, "jwt-access-ttl", 24*time.Hour, "How long access tokens should be valid for.")
	authCmd.PersistentFlags().DurationVar(&JWTRefreshTTL, "jwt-refresh-ttl", 3*24*time.Hour, "How long refresh tokens should be valid for.")
	authCmd.PersistentFlags().StringVar(&RedisAddr, "redis-addr", "", "Address of Redis instance.")
	authCmd.PersistentFlags().StringVar(&RedisUser, "redis-user", "", "Redis username.")
	authCmd.PersistentFlags().StringVar(&RedisPW, "redis-pass", "", "Redis password.")
}
