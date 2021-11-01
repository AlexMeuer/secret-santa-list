package gqlact

import (
	"context"
	"errors"

	gql "github.com/alexmeuer/hasura-util"
	"github.com/alexmeuer/secret-santa-list/pkg/auth"
)

type controller struct {
	GQL  GraphQLClient
	Auth *auth.JWTManager
}

type JSONer interface {
	JSON(status int, body interface{})
}

type RequestContext interface {
	context.Context
	gql.BinderJSON
	JSONer
}

type GraphQLClient interface {
	NamedMutate(ctx context.Context, name string, m interface{}, v map[string]interface{}) error
	NamedQuery(ctx context.Context, name string, q interface{}, v map[string]interface{}) error
}

func New(gql GraphQLClient) (*controller, error) {
	if gql == nil {
		return nil, errors.New("controller: cannot instantiate with nil GraphQLClient")
	}
	return &controller{
		GQL: gql,
	}, nil
}
