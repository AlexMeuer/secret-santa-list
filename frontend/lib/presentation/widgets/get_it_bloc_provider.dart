import 'package:flutter/material.dart' show Key, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secret_santa_list/inject.dart';

class GetItBlocProvider<T extends BlocBase<Object?>> extends BlocProvider<T> {
  GetItBlocProvider({
    Key? key,
    bool? lazy,
    required Widget child,
  }) : super(
          key: key,
          lazy: lazy,
          create: (_) => getIt.get<T>(),
          child: child,
        );
}
