import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secret_santa_list/application/join_room/join_room_bloc.dart';

class RoomPasswordInput extends BlocBuilderBase<JoinRoomBloc, JoinRoomState> {
  const RoomPasswordInput({Key? key})
      : super(key: key, buildWhen: roomPasswordErrorChanged);

  @override
  Widget build(BuildContext context, JoinRoomState state) {
    return TextField(
      autocorrect: false,
      obscureText: true,
      enableSuggestions: false,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        icon: const Icon(Icons.vpn_key),
        labelText: "Room Password",
        errorText: state.roomPasswordError,
      ),
      onChanged: (value) => context
          .read<JoinRoomBloc>()
          .add(JoinRoomEvent.roomPasswordChanged(value)),
    );
  }

  static bool roomPasswordErrorChanged(JoinRoomState p, JoinRoomState c) =>
      p.roomPasswordError != c.roomPasswordError;
}
