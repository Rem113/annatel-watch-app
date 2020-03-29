import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../core/http_client.dart';
import '../../core/token_manager.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged && state.shouldValidateEmail)
      yield* _mapEmailChangedToState(event);
    else if (event is PasswordChanged && state.shouldValidatePassword)
      yield* _mapPasswordChangedToState(event);
    else if (event is FormSubmitted) yield* _mapFormSubmittedToState(event);
  }

  Stream<LoginState> _mapEmailChangedToState(EmailChanged event) async* {
    yield state.update(
      emailError: Validators.validateEmail(event.email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(PasswordChanged event) async* {
    yield state.update(
      passwordError: Validators.validatePassword(event.password),
    );
  }

  Stream<LoginState> _mapFormSubmittedToState(FormSubmitted event) async* {
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
      final tokenManager = TokenManager();
      final client = HTTPClient(tokenManager: tokenManager);
      final authService =
          AuthService(client: client, tokenManager: tokenManager);

      final res = await authService.login(
        email: event.email,
        password: event.password,
      );

      yield res.fold(
        () => state.update(success: true),
        (failure) => state.update(success: false),
      );
    }
  }
}
