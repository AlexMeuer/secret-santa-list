package auth

import (
	"testing"
	"time"

	"github.com/golang-jwt/jwt"
)

func TestJWTCreatesValidTokens(t *testing.T) {
	tknMgr := JWTManager{
		AccessSecret:  []byte{1, 2, 3, 4, 5, 6, 7, 8, 9},
		RefreshSecret: []byte{9, 8, 7, 6, 5, 4, 3, 2, 1},
		AccessTTL:     1 * time.Minute,
		RefreshTTL:    2 * time.Minute,
	}
	userID := "foo"
	nsClaims := map[string]jwt.MapClaims{
		"test": {
			"bar": "baz",
		},
	}
	td, err := tknMgr.Create(userID, nsClaims)
	if err != nil {
		t.Fatal(err.Error())
		return
	}

	// Check the access token.
	tkn, err := tknMgr.Verify(td.AccessToken)
	if err != nil {
		t.Log(err.Error())
		t.Fail()
		return
	}
	if !tkn.Valid {
		t.Log("Expected valid access token to be generated")
		t.Fail()
	}
	if mapClaims, ok := tkn.Claims.(jwt.MapClaims); ok {
		if c, ok := mapClaims["test"]; ok {
			if v, ok := (c.(map[string]interface{}))["bar"]; ok {
				if v != "baz" {
					t.Logf("Expected 'bar' claim to have value 'baz', but was '%s'", v)
					t.Fail()
				}
			} else {
				t.Log("Failed to find 'bar' in token claims.")
				t.Fail()
			}
		} else {
			t.Log("Expected token to have 'test' claims namespace.")
			t.Fail()
		}
	} else {
		t.Log("Token claims were not jwt.MapClaims")
		t.Fail()
	}

	// Check the refresh token
	tkn, err = tknMgr.Verify(td.RefreshToken)
	if err != nil {
		t.Log(err.Error())
		t.Fail()
		return
	}
	if !tkn.Valid {
		t.Log("Expected valid refresh token to be generated")
		t.Fail()
	}
	if mapClaims, ok := tkn.Claims.(jwt.MapClaims); ok {
		if c, ok := mapClaims["test"]; ok {
			t.Logf("Refresh token should not have 'test' claims namespace: '%+v'", c)
			t.Fail()
		}
	} else {
		t.Log("Token claims were not jwt.MapClaims")
		t.Fail()
	}
}
