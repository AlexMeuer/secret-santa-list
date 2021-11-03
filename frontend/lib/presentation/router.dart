import 'package:auto_route/auto_route.dart';
import 'package:secret_santa_list/presentation/pages/join_room/join_room_page.dart';
import 'package:secret_santa_list/presentation/pages/sign_in/sign_in_page.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(page: SignInPage, initial: true),
  AutoRoute(page: JoinRoomPage),
])
class $AppRouter {}
