package auth

import (
	"context"
	"fmt"

	gql "github.com/alexmeuer/hasura-util"
	"github.com/hasura/go-graphql-client"
	"golang.org/x/crypto/bcrypt"
)

type GraphQLPasswordChecker struct {
	Client     *graphql.Client
	BCryptCost int
}

func (pc *GraphQLPasswordChecker) Check(ctx context.Context, name string, password string) error {
	var q struct {
		User []struct {
			Name     string `graphql:"name"`
			Password string `graphql:"password"`
		} `graphql:"user(where: {name: {_ilike: $name}}, limit: 1)"`
	}
	v := gql.Vars{
		"name": gql.String(name),
	}
	if err := pc.Client.NamedQuery(ctx, "AuthUserByPK", &q, v); err != nil {
		return fmt.Errorf("failed to query user: %w", err)
	}
	if len(q.User) > 0 {
		return bcrypt.CompareHashAndPassword([]byte(q.User[0].Password), []byte(password))
	}
	b, err := bcrypt.GenerateFromPassword([]byte(password), pc.BCryptCost)
	if err != nil {
		return fmt.Errorf("failed to generate password hash with bcrypt: %w", err)
	}
	var m struct {
		User gql.Empty `graphql:"insert_user_one(object: {name: $name, password: $pw})"`
	}
	v["pw"] = gql.String(b)
	if err := pc.Client.NamedMutate(ctx, "CreateUser", &m, v); err != nil {
		return fmt.Errorf("failed to create user: %w", err)
	}
	return nil
}
