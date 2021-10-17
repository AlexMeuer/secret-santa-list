package auth

import (
	"time"

	"github.com/golang-jwt/jwt"
)

type JWTCreator struct {
	AccessSecret  []byte
	RefreshSecret []byte
	AccessTTL     time.Duration
	RefreshTTL    time.Duration
	GenerateUUID  func() string
}

type TokenDetails struct {
	AccessToken  string
	RefreshToken string
	AccessUUID   string
	RefreshUUID  string
	AtExpires    int64
	RtExpires    int64
}

func (c *JWTCreator) CreateToken(userID string, namespacedClaims map[string]jwt.MapClaims) (*TokenDetails, error) {
	now := jwt.TimeFunc()
	td := &TokenDetails{}
	td.AtExpires = now.Add(c.AccessTTL).Unix()
	td.AccessUUID = c.GenerateUUID()

	td.RtExpires = now.Add(c.RefreshTTL).Unix()
	td.RefreshUUID = c.GenerateUUID()

	var err error
	// Creating Access Token
	atClaims := jwt.MapClaims{}
	atClaims["authorized"] = true
	atClaims["access_uuid"] = td.AccessUUID
	atClaims["user_id"] = userID
	atClaims["iat"] = now.Unix()
	atClaims["exp"] = td.AtExpires
	for key, value := range namespacedClaims {
		atClaims[key] = value
	}
	at := jwt.NewWithClaims(jwt.SigningMethodHS256, atClaims)
	td.AccessToken, err = at.SignedString(c.AccessSecret)
	if err != nil {
		return nil, err
	}
	// Creating Refresh Token
	rtClaims := jwt.MapClaims{}
	rtClaims["refresh_uuid"] = td.RefreshUUID
	rtClaims["user_id"] = userID
	rtClaims["iat"] = now.Unix()
	rtClaims["exp"] = td.RtExpires
	for key, value := range namespacedClaims {
		atClaims[key] = value
	}
	rt := jwt.NewWithClaims(jwt.SigningMethodHS256, rtClaims)
	td.RefreshToken, err = rt.SignedString(c.RefreshSecret)
	return td, err
}
