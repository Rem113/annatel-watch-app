part of 'register_form_bloc.dart';

abstract class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();
}

class EmailChanged extends RegisterFormEvent {
  final String email;

  EmailChanged({
    @required this.email,
  });

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegisterFormEvent {
  final String password;

  PasswordChanged({
    @required this.password,
  });

  @override
  List<Object> get props => [password];
}

class RegisterAttempt extends RegisterFormEvent {
  final String email;
  final String password;

  RegisterAttempt({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
