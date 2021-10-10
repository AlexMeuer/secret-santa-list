part of 'join_room_bloc.dart';

@freezed
class JoinRoomEvent with _$JoinRoomEvent {
  const factory JoinRoomEvent.started() = _Started;
  const factory JoinRoomEvent.roomNameChanged(String name) = _RoomNameChanged;
  const factory JoinRoomEvent.userNameChanged(String name) = _UserNameChanged;
  const factory JoinRoomEvent.roomPasswordChanged(String pw) =
      _RoomPasswordChanged;
  const factory JoinRoomEvent.userPasswordChanged(String pw) =
      _UserPasswordChanged;
  const factory JoinRoomEvent.joinRequested() = _JoinRequested;
}
