import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../core/http_client.dart';
import '../../core/token_manager.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  @override
  RegisterFormState get initialState => RegisterFormState.initial();

  @override
  Stream<RegisterFormState> mapEventToState(
    RegisterFormEvent event,
  ) async* {
    if (event is RegisterAttempt && !state.submitting)
      yield* _mapRegisterAttemptToState(event);
  }

  Stream<RegisterFormState> _mapRegisterAttemptToState(
      RegisterAttempt event) async* {
    final emailError = Validators.validateEmail(event.email);
    final passwordError = Validators.validatePassword(event.password);
    final passwordConfirmError = Validators.validatePasswordConfirm(
      event.password,
      event.passwordConfirm,
    );

    if (emailError != null ||
        passwordError != null ||
        passwordConfirmError != null) {
      yield RegisterFormState.inputError(
        emailError: emailError,
        passwordError: passwordError,
        passwordConfirmError: passwordConfirmError,
      );
      return;
    }

    yield RegisterFormState.submitting();

    final tokenManager = TokenManager();
    final client = HTTPClient(tokenManager: tokenManager);
    final authService = AuthService(client: client, tokenManager: tokenManager);

    final res = await authService.register(
      email: event.email,
      password: event.password,
    );

    yield res.fold(
      () => RegisterFormState.registered(),
      (failure) => RegisterFormState.serverError(failure.message),
    );
  }
}
