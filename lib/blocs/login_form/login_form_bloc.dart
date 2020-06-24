import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/http_client.dart';
import '../../core/token_manager.dart';
import '../../core/validators.dart';
import '../../services/account_service.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  @override
  LoginFormState get initialState => LoginFormState.initial();

  @override
  Stream<LoginFormState> mapEventToState(
    LoginFormEvent event,
  ) async* {
    if (event is LoginAttempt) yield* _mapLoginAttemptToState(event);
  }

  Stream<LoginFormState> _mapLoginAttemptToState(LoginAttempt event) async* {
    final emailError = Validators.validateEmail(event.email);
    final passwordError = Validators.validatePassword(event.password);

    if (emailError != null || passwordError != null) {
      yield LoginFormState.inputError(
        emailError: emailError,
        passwordError: passwordError,
      );
      return;
    }

    yield LoginFormState.submitting();

    final tokenManager = TokenManager();
    final client = HTTPClient(tokenManager: tokenManager);
    final authService =
        AccountService(client: client, tokenManager: tokenManager);

    final res = await authService.login(
      email: event.email,
      password: event.password,
    );

    yield res.fold(
      () => LoginFormState.loggedIn(),
      (failure) => LoginFormState.serverError(failure.message),
    );
  }
}
