import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secret_santa_list/application/join_room/join_room_bloc.dart';

class RoomNameInput extends BlocBuilderBase<JoinRoomBloc, JoinRoomState> {
  const RoomNameInput({Key? key})
      : super(key: key, buildWhen: roomErrorChanged);

  @override
  Widget build(BuildContext context, JoinRoomState state) {
    return TextField(
      autocorrect: false,
      maxLength: JoinRoomBloc.roomNameMaxLength,
      maxLengthEnforcement: MaxLengthEnforcement.none,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        icon: const Icon(Icons.meeting_room),
        labelText: "Room Name",
        errorText: state.roomNameError,
      ),
      onChanged: (value) => context
          .read<JoinRoomBloc>()
          .add(JoinRoomEvent.roomNameChanged(value)),
    );
  }

  static bool roomErrorChanged(JoinRoomState p, JoinRoomState c) =>
      p.roomNameError != c.roomNameError;
}
