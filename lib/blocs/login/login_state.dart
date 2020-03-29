part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String emailError;
  final String passwordError;
  final bool shouldValidateEmail;
  final bool shouldValidatePassword;
  final bool submitting;
  final bool error;
  final bool success;

  LoginState({
    @required this.emailError,
    @required this.passwordError,
    @required this.shouldValidateEmail,
    @required this.shouldValidatePassword,
    @required this.submitting,
    @required this.error,
    @required this.success,
  });

  factory LoginState.initial() {
    return LoginState(
      emailError: "",
      passwordError: "",
      shouldValidateEmail: false,
      shouldValidatePassword: false,
      submitting: false,
      error: false,
      success: false,
    );
  }

  LoginState update({
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

  LoginState copyWith({
    String emailError,
    String passwordError,
    bool shouldValidateEmail,
    bool shouldValidatePassword,
    bool submitting,
    bool error,
    bool success,
  }) {
    return LoginState(
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
