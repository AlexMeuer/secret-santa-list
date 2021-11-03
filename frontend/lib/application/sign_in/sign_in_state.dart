part of 'sign_in_bloc.dart';

@freezed
@immutable
class SignInState with _$SignInState {
  const factory SignInState({
    required String name,
    required String password,
    required bool working,
    String? nameError,
    String? pwError,
  }) = _SignInState;

  const SignInState._();

  factory SignInState.initial() => const SignInState(
        name: "",
        password: "",
        working: false,
      );

  bool get hasError => nameError != null || pwError != null;

  bool get hasEmpty => name.isEmpty || password.isEmpty;
}
