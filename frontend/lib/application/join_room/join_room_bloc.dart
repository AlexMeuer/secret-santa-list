import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

part 'join_room_event.dart';
part 'join_room_state.dart';
part 'join_room_bloc.freezed.dart';

@injectable
class JoinRoomBloc extends Bloc<JoinRoomEvent, JoinRoomState> {
  static const roomNameMaxLength = 20;
  static const userNameMaxLength = 30;

  final GraphQLClient _gql;

  JoinRoomBloc(this._gql) : super(JoinRoomState.initial()) {
    on<_RoomNameChanged>((event, emit) async {
      String? err;
      if (event.name.length > roomNameMaxLength) {
        err = "Too long!";
      }
      emit(state.copyWith(
        roomName: event.name,
        roomNameError: err,
      ));
    });

    on<_UserNameChanged>((event, emit) async {
      String? err;
      if (event.name.length > userNameMaxLength) {
        err = "Too long!";
      }
      emit(state.copyWith(
        userName: event.name,
        userNameError: err,
      ));
    });

    on<_RoomPasswordChanged>((event, emit) async {
      emit(state.copyWith(
        roomPassword: event.pw,
      ));
    });

    on<_UserPasswordChanged>((event, emit) async {
      emit(state.copyWith(
        userPassword: event.pw,
      ));
    });

    on<_JoinRequested>((event, emit) async {
      emit(state.copyWith(
        joiningRoom: true,
      ));
      final result = await _gql.mutate(
        MutationOptions(
          document: gql(r'''
mutation ClientCreateOrJoinRoom($room: String!, $user: String!, $room_pw: String = "", $user_pw: String = "") {
  join_room(params: {room: $room, user: $user, room_pw: $room_pw, user_pw: $user_pw}) {
    room_name
  }
}'''),
          variables: {
            "room": state.roomName,
            "user": state.userName,
            "room_pw": state.roomPassword,
            "user_pw": state.userPassword,
          },
        ),
      );
      emit(state.copyWith(
        joiningRoom: false,
      ));
      if (result.hasException) {
        print(result.exception);
      } else {
        print(result.data);
      }
    });
  }
}
