part of 'sign_in_bloc.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.nameChanged(String name) = _NameChanged;
  const factory SignInEvent.passwordChanged(String pw) = _PasswordChanged;
  const factory SignInEvent.signInRequested() = _SignInRequested;
}
