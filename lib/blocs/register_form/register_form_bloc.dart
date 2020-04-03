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
    if (event is EmailChanged && state.shouldValidateEmail)
      yield* _mapEmailChangedToState(event);
    else if (event is PasswordChanged && state.shouldValidatePassword)
      yield* _mapPasswordChangedToState(event);
    else if (event is RegisterAttempt) yield* _mapFormSubmittedToState(event);
  }

  Stream<RegisterFormState> _mapEmailChangedToState(EmailChanged event) async* {
    yield state.update(
      emailError: Validators.validateEmail(event.email),
    );
  }

  Stream<RegisterFormState> _mapPasswordChangedToState(
      PasswordChanged event) async* {
    yield state.update(
      passwordError: Validators.validatePassword(event.password),
    );
  }

  Stream<RegisterFormState> _mapFormSubmittedToState(
      RegisterAttempt event) async* {
    final emailError = Validators.validateEmail(event.email);
    final passwordError = Validators.validatePassword(event.password);
    if (emailError.isNotEmpty || passwordError.isNotEmpty)
      yield state.update(
        shouldValidateEmail: true,
        shouldValidatePassword: true,
        emailError: emailError,
        passwordError: passwordError,
      );
    else {
      yield state.update(
        emailError: "",
        passwordError: "",
        success: false,
        submitting: true,
        error: false,
      );

      final tokenManager = TokenManager();
      final client = HTTPClient(tokenManager: tokenManager);
      final authService =
          AuthService(client: client, tokenManager: tokenManager);

      final res = await authService.register(
        email: event.email,
        password: event.password,
      );

      yield res.fold(
        () => state.update(
          success: true,
          submitting: false,
          error: false,
        ),
        (failure) => state.update(
          success: false,
          submitting: false,
          error: true,
        ),
      );
    }
  }
}
