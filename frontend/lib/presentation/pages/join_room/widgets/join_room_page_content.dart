import 'package:flutter/material.dart';
import 'package:secret_santa_list/presentation/pages/join_room/widgets/join_button.dart';
import 'package:secret_santa_list/presentation/pages/join_room/widgets/room_name_input.dart';
import 'package:secret_santa_list/presentation/pages/join_room/widgets/room_password_input.dart';
import 'package:secret_santa_list/presentation/pages/join_room/widgets/user_name_input.dart';
import 'package:secret_santa_list/presentation/pages/join_room/widgets/user_password_input.dart';

class JoinRoomPageContent extends StatelessWidget {
  const JoinRoomPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: RoomNameInput(),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: RoomPasswordInput(),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(8),
              child: UserNameInput(),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: UserPasswordInput(),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: JoinButton(),
            ),
          ],
        ),
      ),
    );
  }
}
