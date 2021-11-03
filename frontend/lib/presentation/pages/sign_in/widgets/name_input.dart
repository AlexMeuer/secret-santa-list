import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secret_santa_list/application/sign_in/sign_in_bloc.dart';

class NameInput extends BlocBuilderBase<SignInBloc, SignInState> {
  const NameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SignInState state) {
    return TextField(
      autocorrect: false,
      maxLength: SignInBloc.nameMaxLength,
      maxLengthEnforcement: MaxLengthEnforcement.none,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        icon: const Icon(Icons.person),
        labelText: "Your Name",
        errorText: state.nameError,
      ),
      onChanged: (value) =>
          context.read<SignInBloc>().add(SignInEvent.nameChanged(value)),
    );
  }

  static bool nameErrorChanged(SignInState p, SignInState c) =>
      p.nameError != c.nameError;
}
