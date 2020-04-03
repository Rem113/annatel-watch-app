part of 'register_form_bloc.dart';

abstract class RegisterFormEvent {
  const RegisterFormEvent();
}

class RegisterAttempt extends RegisterFormEvent {
  final String email;
  final String password;
  final String passwordConfirm;

  RegisterAttempt({
    @required this.email,
    @required this.password,
    @required this.passwordConfirm,
  });
}
