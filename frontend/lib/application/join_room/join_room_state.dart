part of 'join_room_bloc.dart';

@freezed
@immutable
class JoinRoomState with _$JoinRoomState {
  const factory JoinRoomState({
    required String roomName,
    required String userName,
    required String roomPassword,
    required String userPassword,
    required bool joiningRoom,
    String? roomNameError,
    String? userNameError,
    String? roomPasswordError,
    String? userPasswordError,
  }) = _JoinRoomState;

  const JoinRoomState._();

  factory JoinRoomState.initial() => const JoinRoomState(
        roomName: "",
        userName: "",
        roomPassword: "",
        userPassword: "",
        joiningRoom: false,
      );

  bool get hasError =>
      roomNameError != null ||
      userNameError != null ||
      roomPasswordError != null ||
      userPasswordError != null;

  bool get hasEmpty => roomName.isEmpty || userName.isEmpty;
}
