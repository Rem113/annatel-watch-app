part of 'login_form_bloc.dart';

abstract class LoginFormEvent {
  const LoginFormEvent();
}

class FormSubmitted extends LoginFormEvent {
  final String email;
  final String password;

  FormSubmitted({
    @required this.email,
    @required this.password,
  });
}
