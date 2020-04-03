part of 'login_form_bloc.dart';

@immutable
class LoginFormState {
  final String emailError;
  final String passwordError;
  final bool submitting;
  final String serverError;
  final bool loggedIn;

  LoginFormState({
    @required this.emailError,
    @required this.passwordError,
    @required this.submitting,
    @required this.serverError,
    @required this.loggedIn,
  });

  factory LoginFormState.initial() {
    return LoginFormState(
      emailError: null,
      passwordError: null,
      submitting: false,
      serverError: null,
      loggedIn: false,
    );
  }

  factory LoginFormState.inputError({
    @required String emailError,
    @required String passwordError,
  }) {
    return LoginFormState(
      emailError: emailError,
      passwordError: passwordError,
      submitting: false,
      serverError: null,
      loggedIn: false,
    );
  }

  factory LoginFormState.submitting() {
    return LoginFormState(
      emailError: null,
      passwordError: null,
      submitting: true,
      serverError: null,
      loggedIn: false,
    );
  }

  factory LoginFormState.serverError(String serverError) {
    return LoginFormState(
      emailError: null,
      passwordError: null,
      submitting: false,
      serverError: serverError,
      loggedIn: false,
    );
  }

  factory LoginFormState.loggedIn() {
    return LoginFormState(
      emailError: null,
      passwordError: null,
      submitting: false,
      serverError: null,
      loggedIn: true,
    );
  }
}
