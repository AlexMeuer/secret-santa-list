package gqlact

import (
	"net/http"

	gql "github.com/alexmeuer/graphql-util"
	"github.com/gin-gonic/gin"
	"github.com/rs/zerolog/log"
	"golang.org/x/crypto/bcrypt"
)

func (c *controller) CreateOrJoinRoom(ctx *gin.Context) {
	var params struct {
		RoomName string `json:"room"`
		RoomPW   string `json:"room_pw"`
		UserName string `json:"user"`
		UserPW   string `json:"user_pw"`
	}
	_, err := gql.UnmarshalHasuraAction(ctx, &params)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gql.ErrFrom(err))
		return
	}

	var q struct {
		Room struct {
			Name string `graphql:"name"`
			PW   string `graphql:"password"`
		} `graphql:"room_by_pk(name: $room)"`
		User struct {
			Name string `graphql:"name"`
			PW   string `graphql:"password"`
		} `graphql:"user_by_pk(name: $user)"`
		Membership struct {
			UserName string `graphql:"user_name"`
		} `graphql:"room_user_by_pk(room_name: $room, user_name: $user)"`
	}
	v := gql.Vars{
		"room": gql.String(params.RoomName),
		"user": gql.String(params.UserName),
	}
	if err := c.GQL.NamedQuery(ctx, "RoomAndUserByPK", &q, v); err != nil {
		log.Err(err).Interface("vars", v).Str("category", "room.create_or_join").Msg("Failed to query room and user by PK.")
		ctx.JSON(http.StatusInternalServerError, gql.ErrFrom(err))
		return
	}

	log.Error().Interface("q", &q).Interface("params", &params).Msg("FOO")

	if len(q.Room.PW) > 0 {
		if err := bcrypt.CompareHashAndPassword([]byte(q.Room.PW), []byte(params.RoomPW)); err != nil {
			ctx.JSON(http.StatusForbidden, gql.ErrFrom(err))
			return
		}
	}
	if len(q.User.PW) > 0 {
		if err := bcrypt.CompareHashAndPassword([]byte(q.Room.PW), []byte(params.UserPW)); err != nil {
			ctx.JSON(http.StatusForbidden, gql.ErrFrom(err))
			return
		}
	}

	// TODO: refactor this!
	if q.Membership.UserName != "" {
		ctx.JSON(http.StatusOK, gin.H{
			"room_name": params.RoomName,
			"user_name": params.UserName,
		})
		return
	} else if q.Room.Name == "" && q.User.Name == "" {
		var m struct {
			User       gql.Empty `graphql:"insert_user_one(object: {name: $user, password: $user_pw})"`
			Room       gql.Empty `graphql:"insert_room_one(object: {name: $room, password: $room_pw})"`
			Membership gql.Empty `graphql:"insert_room_user_one(object: {room_name: $room, user_name: $user})"`
		}
		if err := addPasswordToVars(v, "room_pw", params.RoomPW); err != nil {
			log.Err(err).Str("category", "room.create_or_join").Msg("Failed to hash room password and add to vars.")
			ctx.JSON(http.StatusInternalServerError, gql.ErrFrom(err))
			return
		}
		if err := addPasswordToVars(v, "user_pw", params.UserPW); err != nil {
			log.Err(err).Str("category", "room.create_or_join").Msg("Failed to hash user password and add to vars.")
			ctx.JSON(http.StatusInternalServerError, gql.ErrFrom(err))
			return
		}
		if err := c.GQL.NamedMutate(ctx, "CreateRoomAndUser", &m, v); err != nil {
			log.Err(err).Interface("vars", v).Str("category", "room.create_or_join").Msg("Failed to create room and user.")
			ctx.JSON(http.StatusInternalServerError, gql.ErrFrom(err))
			return
		}
	} else if q.Room.Name == "" {
		var m struct {
			Room       gql.Empty `graphql:"insert_room_one(object: {name: $room, password: $room_pw})"`
			Membership gql.Empty `graphql:"insert_room_user_one(object: {room_name: $room, user_name: $user})"`
		}
		if err := addPasswordToVars(v, "room_pw", params.RoomPW); err != nil {
			log.Err(err).Str("category", "room.create_or_join").Msg("Failed to hash room password and add to vars.")
			ctx.JSON(http.StatusInternalServerError, gql.ErrFrom(err))
			return
		}
		if err := c.GQL.NamedMutate(ctx, "CreateRoom", &m, v); err != nil {
			log.Err(err).Interface("vars", v).Str("category", "room.create_or_join").Msg("Failed to create room and join it.")
			ctx.JSON(http.StatusInternalServerError, gql.ErrFrom(err))
			return
		}
	} else if q.User.Name == "" {
		var m struct {
			User       gql.Empty `graphql:"insert_user_one(object: {name: $user, password: $user_pw})"`
			Membership gql.Empty `graphql:"insert_room_user_one(object: {room_name: $room, user_name: $user})"`
		}
		if err := addPasswordToVars(v, "user_pw", params.UserPW); err != nil {
			log.Err(err).Str("category", "room.create_or_join").Msg("Failed to hash user password and add to vars.")
			ctx.JSON(http.StatusInternalServerError, gql.ErrFrom(err))
			return
		}
		if err := c.GQL.NamedMutate(ctx, "CreateUser", &m, v); err != nil {
			log.Err(err).Interface("vars", v).Str("category", "room.create_or_join").Msg("Failed to create user and join room.")
			ctx.JSON(http.StatusInternalServerError, gql.ErrFrom(err))
			return
		}
	} else {
		var m struct {
			Membership gql.Empty `graphql:"insert_room_user_one(object: {room_name: $room, user_name: $user})"`
		}
		if err := c.GQL.NamedMutate(ctx, "JoinRoom", &m, v); err != nil {
			log.Err(err).Interface("vars", v).Str("category", "room.create_or_join").Msg("Failed to join room.")
			ctx.JSON(http.StatusInternalServerError, gql.ErrFrom(err))
			return
		}
	}

	ctx.JSON(http.StatusOK, gin.H{
		"room_name": params.RoomName,
		"user_name": params.UserName,
	})
}

func addPasswordToVars(v gql.Vars, key, pw string) error {
	if len(pw) > 0 {
		if hash, err := bcrypt.GenerateFromPassword([]byte(pw), bcrypt.DefaultCost); err != nil {
			return err
		} else {
			str := string(hash)
			v[key] = (*gql.String)(&str)
		}
	} else {
		v[key] = (*gql.String)(nil)
	}
	return nil
}
