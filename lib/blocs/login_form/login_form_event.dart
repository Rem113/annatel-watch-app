part of 'login_form_bloc.dart';

abstract class LoginFormEvent {
  const LoginFormEvent();
}

class LoginAttempt extends LoginFormEvent {
  final String email;
  final String password;

  LoginAttempt({
    @required this.email,
    @required this.password,
  });
}
