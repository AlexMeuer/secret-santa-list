import 'package:flutter/material.dart';
import 'package:secret_santa_list/presentation/router.gr.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    return MaterialApp.router(
      title: "Secret Santa List Tracker",
      theme: ThemeData(
        primarySwatch: Colors.green,
        errorColor: Colors.pink,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
