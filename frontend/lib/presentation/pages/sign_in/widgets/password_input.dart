import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secret_santa_list/application/sign_in/sign_in_bloc.dart';

class UserPasswordInput extends BlocBuilderBase<SignInBloc, SignInState> {
  const UserPasswordInput({Key? key})
      : super(key: key, buildWhen: passwordErrorChanged);

  @override
  Widget build(BuildContext context, SignInState state) {
    return TextField(
      autocorrect: false,
      obscureText: true,
      enableSuggestions: false,
      maxLength: SignInBloc.pwMaxLength,
      maxLengthEnforcement: MaxLengthEnforcement.none,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        icon: const Icon(Icons.password),
        labelText: "Password",
        errorText: state.pwError,
      ),
      onChanged: (value) =>
          context.read<SignInBloc>().add(SignInEvent.passwordChanged(value)),
    );
  }

  static bool passwordErrorChanged(SignInState p, SignInState c) =>
      p.pwError != c.pwError;
}
