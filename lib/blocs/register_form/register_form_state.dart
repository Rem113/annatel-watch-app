part of 'register_form_bloc.dart';

class RegisterFormState extends Equatable {
  final String emailError;
  final String passwordError;
  final bool shouldValidateEmail;
  final bool shouldValidatePassword;
  final bool submitting;
  final bool error;
  final bool success;

  RegisterFormState({
    @required this.emailError,
    @required this.passwordError,
    @required this.shouldValidateEmail,
    @required this.shouldValidatePassword,
    @required this.submitting,
    @required this.error,
    @required this.success,
  });

  factory RegisterFormState.initial() {
    return RegisterFormState(
      emailError: "",
      passwordError: "",
      shouldValidateEmail: false,
      shouldValidatePassword: false,
      submitting: false,
      error: false,
      success: false,
    );
  }

  RegisterFormState update({
    String emailError,
    String passwordError,
    bool shouldValidateEmail,
    bool shouldValidatePassword,
    bool submitting,
    bool error,
    bool success,
  }) {
    return copyWith(
      emailError: emailError,
      passwordError: passwordError,
      shouldValidateEmail: shouldValidateEmail,
      shouldValidatePassword: shouldValidatePassword,
      submitting: submitting,
      error: error,
      success: success,
    );
  }

  RegisterFormState copyWith({
    String emailError,
    String passwordError,
    bool shouldValidateEmail,
    bool shouldValidatePassword,
    bool submitting,
    bool error,
    bool success,
  }) {
    return RegisterFormState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      shouldValidateEmail: shouldValidateEmail ?? this.shouldValidateEmail,
      shouldValidatePassword:
          shouldValidatePassword ?? this.shouldValidatePassword,
      submitting: submitting ?? this.submitting,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object> get props => [
        emailError,
        passwordError,
        shouldValidateEmail,
        shouldValidatePassword,
        submitting,
        error,
        success,
      ];
}
