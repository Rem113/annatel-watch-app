part of 'register_form_bloc.dart';

@immutable
class RegisterFormState {
  final String emailError;
  final String passwordError;
  final String passwordConfirmError;
  final bool submitting;
  final String serverError;
  final bool registered;

  RegisterFormState({
    @required this.emailError,
    @required this.passwordError,
    @required this.passwordConfirmError,
    @required this.submitting,
    @required this.serverError,
    @required this.registered,
  });

  factory RegisterFormState.initial() {
    return RegisterFormState(
      emailError: null,
      passwordError: null,
      passwordConfirmError: null,
      submitting: false,
      serverError: null,
      registered: false,
    );
  }

  factory RegisterFormState.inputError({
    @required String emailError,
    @required String passwordError,
    @required String passwordConfirmError,
  }) {
    return RegisterFormState(
      emailError: emailError,
      passwordError: passwordError,
      passwordConfirmError: passwordConfirmError,
      submitting: false,
      serverError: null,
      registered: false,
    );
  }

  factory RegisterFormState.submitting() {
    return RegisterFormState(
      emailError: null,
      passwordError: null,
      passwordConfirmError: null,
      submitting: true,
      serverError: null,
      registered: false,
    );
  }

  factory RegisterFormState.serverError(String serverError) {
    return RegisterFormState(
      emailError: null,
      passwordError: null,
      passwordConfirmError: null,
      submitting: false,
      serverError: serverError,
      registered: false,
    );
  }

  factory RegisterFormState.registered() {
    return RegisterFormState(
      emailError: null,
      passwordError: null,
      passwordConfirmError: null,
      submitting: false,
      serverError: null,
      registered: true,
    );
  }
}
