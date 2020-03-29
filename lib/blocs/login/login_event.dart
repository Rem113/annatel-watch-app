part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({
    @required this.email,
  });

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({
    @required this.password,
  });

  @override
  List<Object> get props => [password];
}

class FormSubmitted extends LoginEvent {
  final String email;
  final String password;

  FormSubmitted({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
