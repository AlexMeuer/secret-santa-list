import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secret_santa_list/application/join_room/join_room_bloc.dart';

class UserNameInput extends BlocBuilderBase<JoinRoomBloc, JoinRoomState> {
  const UserNameInput({Key? key})
      : super(key: key, buildWhen: userErrorChanged);

  @override
  Widget build(BuildContext context, JoinRoomState state) {
    return TextField(
      autocorrect: false,
      maxLength: JoinRoomBloc.userNameMaxLength,
      maxLengthEnforcement: MaxLengthEnforcement.none,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        icon: const Icon(Icons.person),
        labelText: "Your Name",
        errorText: state.userNameError,
      ),
      onChanged: (value) => context
          .read<JoinRoomBloc>()
          .add(JoinRoomEvent.userNameChanged(value)),
    );
  }

  static bool userErrorChanged(JoinRoomState p, JoinRoomState c) =>
      p.roomNameError != c.roomNameError;
}
