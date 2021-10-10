import 'package:auto_route/auto_route.dart';
import 'package:secret_santa_list/presentation/pages/join_room/join_room_page.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(page: JoinRoomPage, initial: true),
])
class $AppRouter {} 