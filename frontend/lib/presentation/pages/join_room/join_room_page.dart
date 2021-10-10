import 'package:flutter/material.dart';
import 'package:secret_santa_list/application/join_room/join_room_bloc.dart';
import 'package:secret_santa_list/presentation/pages/join_room/widgets/join_room_page_content.dart';
import 'package:secret_santa_list/presentation/widgets/get_it_bloc_provider.dart';

class JoinRoomPage extends StatelessWidget {
  const JoinRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Room"),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFFDE4DAA),
              Color(0xFFF6D327),
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: SingleChildScrollView(
              child: GetItBlocProvider<JoinRoomBloc>(
                child: const JoinRoomPageContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
