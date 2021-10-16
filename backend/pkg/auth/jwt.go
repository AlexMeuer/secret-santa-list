package auth

// TODO refactor this into its own package

import (
	"time"

	"github.com/golang-jwt/jwt"
)

type JWTAuth struct {
	Secret string
}

type OptionFunc func(jwt.MapClaims)

func (a *JWTAuth) CreateToken(userID string, options ...OptionFunc) (string, error) {
	claims := jwt.MapClaims{}
	for _, opt := range options {
		opt(claims)
	}
	claims["user_id"] = userID
	claims["iat"] = jwt.TimeFunc().Unix()
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(a.Secret)
}

// WithExpiryAt sets the JWT expiry to a specific time.
func WithExpiryAt(t time.Time) OptionFunc {
	return func(claims jwt.MapClaims) {
		claims["exp"] = t.Unix()
	}
}

// WithExpiryIn sets the JWT expiry to a specific time from now.
func WithExpiryIn(d time.Duration) OptionFunc {
	return WithExpiryAt(jwt.TimeFunc().Add(d))
}

// WithClaims adds custom claims under a given namespace.
// Calling multiple times with the same namespace will overwrite claims, not merge them.
func WithClaims(ns string, nsClaims jwt.MapClaims) OptionFunc {
	return func(claims jwt.MapClaims) {
		claims[ns] = nsClaims
	}
}
