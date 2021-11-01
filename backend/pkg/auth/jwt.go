package auth

import (
	"errors"
	"fmt"
	"time"

	"github.com/golang-jwt/jwt"
	"github.com/google/uuid"
)

const (
	ClaimKeyAccessUUID  = "access_uuid"
	ClaimKeyRefreshUUID = "refresh_uuid"
)

type JWTManager struct {
	AccessSecret  []byte
	RefreshSecret []byte
	AccessTTL     time.Duration
	RefreshTTL    time.Duration
	GenerateUUID  func() string
}

type OutboundTokenDetails struct {
	AccessToken  string `json:"access_token"`
	RefreshToken string `json:"refresh_token"`
	AccessUUID   string `json:"-"`
	RefreshUUID  string `json:"-"`
	AtExpires    int64  `json:"-"`
	RtExpires    int64  `json:"-"`
}

type InboundTokenDetails struct {
	UUID   string
	UserID string
	Claims jwt.MapClaims
}

func (m *JWTManager) Create(userID string, namespacedClaims map[string]jwt.MapClaims) (*OutboundTokenDetails, error) {
	if m.GenerateUUID == nil {
		m.GenerateUUID = uuid.NewString
	}
	now := jwt.TimeFunc()
	td := &OutboundTokenDetails{}
	td.AtExpires = now.Add(m.AccessTTL).Unix()
	td.AccessUUID = m.GenerateUUID()

	td.RtExpires = now.Add(m.RefreshTTL).Unix()
	td.RefreshUUID = m.GenerateUUID()

	var err error
	// Creating Access Token
	atClaims := jwt.MapClaims{}
	atClaims["authorized"] = true
	atClaims[ClaimKeyAccessUUID] = td.AccessUUID
	atClaims["user_id"] = userID
	atClaims["iat"] = now.Unix()
	atClaims["exp"] = td.AtExpires
	for key, value := range namespacedClaims {
		atClaims[key] = value
	}
	at := jwt.NewWithClaims(jwt.SigningMethodHS256, atClaims)
	at.Header["kid"] = "a"
	td.AccessToken, err = at.SignedString(m.AccessSecret)
	if err != nil {
		return nil, err
	}
	// Creating Refresh Token
	rtClaims := jwt.MapClaims{}
	rtClaims[ClaimKeyRefreshUUID] = td.RefreshUUID
	rtClaims["user_id"] = userID
	rtClaims["iat"] = now.Unix()
	rtClaims["exp"] = td.RtExpires
	for key, value := range namespacedClaims {
		atClaims[key] = value
	}
	rt := jwt.NewWithClaims(jwt.SigningMethodHS256, rtClaims)
	rt.Header["kid"] = "r"
	td.RefreshToken, err = rt.SignedString(m.RefreshSecret)
	return td, err
}

func (m *JWTManager) Verify(tknStr string) (*jwt.Token, error) {
	return jwt.Parse(tknStr, func(tkn *jwt.Token) (interface{}, error) {
		//Make sure that the token method conform to "SigningMethodHMAC"
		if _, ok := tkn.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", tkn.Header["alg"])
		}
		kID, ok := tkn.Header["kid"]
		if !ok {
			return nil, errors.New("no kid (key id) in token header")
		}
		switch kID {
		case "a":
			return m.AccessSecret, nil
		case "r":
			return m.RefreshSecret, nil
		default:
			return nil, fmt.Errorf("unexpected kid (key id) in token header: %v", kID)
		}
	})
}

// ExtractDetail attempts to extract the UUID and UserID from the given JWT.
// If reqKID is not empty, then the key ID header of the JWT must match it or an
// error will be returned.
func ExtractDetail(tkn *jwt.Token, reqKID string) (*InboundTokenDetails, error) {
	if !tkn.Valid {
		return nil, errors.New("token is not valid")
	}
	keyID, ok := tkn.Header["kid"].(string)
	if !ok {
		return nil, fmt.Errorf("unable to read token key id from header: %v", tkn.Header)
	}
	if reqKID != "" && keyID != reqKID {
		return nil, fmt.Errorf("unexpected key id '%s' but got '%s'", reqKID, keyID)
	}
	var UUIDClaimKey string
	switch keyID {
	case "a":
		UUIDClaimKey = ClaimKeyAccessUUID
	case "r":
		UUIDClaimKey = ClaimKeyRefreshUUID
	default:
		return nil, fmt.Errorf("unrecognized key id: %s", keyID)
	}
	details := &InboundTokenDetails{}
	details.Claims, ok = tkn.Claims.(jwt.MapClaims)
	if !ok {
		return nil, fmt.Errorf("unable to read token claims as map claims: %v", tkn.Claims)
	}
	details.UUID, ok = details.Claims[UUIDClaimKey].(string)
	if !ok {
		return nil, fmt.Errorf("failed to find %s in token claims", UUIDClaimKey)
	}
	details.UserID, ok = details.Claims["user_id"].(string)
	if !ok {
		return nil, errors.New("failed to find user_id in token claims")
	}
	return details, nil
}
