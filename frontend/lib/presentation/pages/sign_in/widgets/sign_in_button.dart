import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secret_santa_list/application/sign_in/sign_in_bloc.dart';

class SignInButton extends BlocBuilderBase<SignInBloc, SignInState> {
  const SignInButton({Key? key}) : super(key: key, buildWhen: shouldRebuild);

  @override
  Widget build(BuildContext context, SignInState state) {
    return ElevatedButton(
      onPressed: state.hasError || state.hasEmpty || state.working
          ? null
          : () => context
              .read<SignInBloc>()
              .add(const SignInEvent.signInRequested()),
      child: state.working
          ? const CircularProgressIndicator.adaptive()
          : const Text(
              "Sign In / Sign Up",
              style: TextStyle(fontSize: 32),
            ),
    );
  }

  static bool shouldRebuild(SignInState p, SignInState c) =>
      (p.hasEmpty || p.hasError) != (c.hasEmpty || c.hasError);
}
