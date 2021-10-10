// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import 'pages/join_room/join_room_page.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    JoinRoomPageRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.JoinRoomPage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes =>
      [_i2.RouteConfig(JoinRoomPageRoute.name, path: '/')];
}

/// generated route for [_i1.JoinRoomPage]
class JoinRoomPageRoute extends _i2.PageRouteInfo<void> {
  const JoinRoomPageRoute() : super(name, path: '/');

  static const String name = 'JoinRoomPageRoute';
}
