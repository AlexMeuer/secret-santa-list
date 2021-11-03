import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  static const nameMaxLength = 30;
  static const pwMaxLength = 60;

  SignInBloc() : super(SignInState.initial()) {
    on<_NameChanged>((event, emit) {
      String? err;
      if (event.name.length > nameMaxLength) {
        err = "Too long!";
      }
      emit(state.copyWith(
        name: event.name,
        nameError: err,
      ));
    });
    on<_PasswordChanged>((event, emit) {
      String? err;
      if (event.pw.length > pwMaxLength) {
        err = "Too long!";
      }
      emit(state.copyWith(
        password: event.pw,
        pwError: err,
      ));
    });
    on<_SignInRequested>((event, emit) {
      emit(state.copyWith(working: true));

      emit(state.copyWith(working: false));
    });
  }
}
