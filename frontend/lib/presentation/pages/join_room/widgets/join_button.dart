import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secret_santa_list/application/join_room/join_room_bloc.dart';

class JoinButton extends BlocBuilderBase<JoinRoomBloc, JoinRoomState> {
  const JoinButton({Key? key}) : super(key: key, buildWhen: shouldRebuild);

  @override
  Widget build(BuildContext context, JoinRoomState state) {
    return ElevatedButton(
      onPressed: state.hasError || state.hasEmpty || state.joiningRoom
          ? null
          : () => context
              .read<JoinRoomBloc>()
              .add(const JoinRoomEvent.joinRequested()),
      child: state.joiningRoom
          ? const CircularProgressIndicator.adaptive()
          : const Text(
              "Join",
              style: TextStyle(fontSize: 32),
            ),
    );
  }

  static bool shouldRebuild(JoinRoomState p, JoinRoomState c) =>
      (p.hasEmpty || p.hasError) != (c.hasEmpty || c.hasError);
}
