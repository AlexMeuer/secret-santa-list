package auth

import (
	"time"

	"github.com/go-redis/redis/v7"
)

type RedisTokenStore struct {
	Client *redis.Client
}

func (r *RedisTokenStore) Set(userID string, td *OutboundTokenDetails) error {
	at := time.Unix(td.AtExpires, 0)
	rt := time.Unix(td.RtExpires, 0)
	now := time.Now()

	status := r.Client.Set(td.AccessUUID, userID, at.Sub(now))
	if status.Err() != nil {
		return status.Err()
	}
	status = r.Client.Set(td.RefreshUUID, userID, rt.Sub(now))
	return status.Err()
}

func (r *RedisTokenStore) Get(ID string) (string, error) {
	return r.Client.Get(ID).Result()
}

func (r *RedisTokenStore) Del(ID string) error {
	return r.Client.Del(ID).Err()
}
