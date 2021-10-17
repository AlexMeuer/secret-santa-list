package auth

import (
	"context"

	gql "github.com/alexmeuer/graphql-util"
	"github.com/hasura/go-graphql-client"
	"golang.org/x/crypto/bcrypt"
)

type GraphQLPasswordChecker struct {
	Client *graphql.Client
}

func (pc *GraphQLPasswordChecker) Check(ctx context.Context, name string, password string) error {
	var q struct {
		User struct {
			Password string `graphql:"password"`
		} `graphql:""`
	}
	v := gql.Vars{
		"name": gql.String(name),
	}
	if err := pc.Client.NamedQuery(ctx, "UserPasswordByPK", &q, v); err != nil {
		return err
	}
	return bcrypt.CompareHashAndPassword([]byte(q.User.Password), []byte(password))
}
