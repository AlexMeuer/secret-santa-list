package gqlact

import (
	"context"
	"errors"

	gql "github.com/alexmeuer/graphql-util"
)

type controller struct {
	GQL GraphQLClient
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
