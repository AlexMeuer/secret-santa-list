import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secret_santa_list/application/join_room/join_room_bloc.dart';

class UserPasswordInput extends BlocBuilderBase<JoinRoomBloc, JoinRoomState> {
  const UserPasswordInput({Key? key})
      : super(key: key, buildWhen: userPasswordErrorChanged);

  @override
  Widget build(BuildContext context, JoinRoomState state) {
    return TextField(
      autocorrect: false,
      obscureText: true,
      enableSuggestions: false,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        icon: const Icon(Icons.password),
        labelText: "Your Password (if you have one)",
        errorText: state.userPasswordError,
      ),
      onChanged: (value) => context
          .read<JoinRoomBloc>()
          .add(JoinRoomEvent.userPasswordChanged(value)),
    );
  }

  static bool userPasswordErrorChanged(JoinRoomState p, JoinRoomState c) =>
      p.userPasswordError != c.userPasswordError;
}
