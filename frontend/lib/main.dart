import 'package:flutter/material.dart';
import 'package:secret_santa_list/inject.dart';
import 'package:secret_santa_list/presentation/app.dart';

void main() {
  configureDependencies();
  runApp(const App());
}
