package auth

import (
	"context"

	gql "github.com/alexmeuer/graphql-util"
	"github.com/hasura/go-graphql-client"
	"golang.org/x/crypto/bcrypt"
)

type GraphQLPasswordChecker struct {
	Client     *graphql.Client
	BCryptCost int
}

func (pc *GraphQLPasswordChecker) Check(ctx context.Context, name string, password string) error {
	var q struct {
		User struct {
			Name     string `graphql:"name"`
			Password string `graphql:"password"`
		} `graphql:""` // TODO
	}
	v := gql.Vars{
		"name": gql.String(name),
	}
	if err := pc.Client.NamedQuery(ctx, "AuthUserByPK", &q, v); err != nil {
		return err
	}
	if q.User.Name != "" {
		return bcrypt.CompareHashAndPassword([]byte(q.User.Password), []byte(password))
	}
	var m struct {
		User gql.Empty `graphql:""` // TODO
	}
	b, err := bcrypt.GenerateFromPassword([]byte(password), pc.BCryptCost)
	if err != nil {
		return err
	}
	v["pw"] = gql.String(b)
	return pc.Client.NamedMutate(ctx, "CreateUser", &m, v)
}
