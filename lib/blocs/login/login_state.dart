part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String emailError;
  final String passwordError;
  final bool shouldValidateEmail;
  final bool shouldValidatePassword;
  final bool success;

  LoginState({
    @required this.emailError,
    @required this.passwordError,
    @required this.shouldValidateEmail,
    @required this.shouldValidatePassword,
    @required this.success,
  });

  factory LoginState.initial() {
    return LoginState(
      emailError: "",
      passwordError: "",
      shouldValidateEmail: false,
      shouldValidatePassword: false,
      success: false,
    );
  }

  LoginState update({
    String emailError,
    String passwordError,
    bool shouldValidateEmail,
    bool shouldValidatePassword,
    bool success,
  }) {
    return copyWith(
      emailError: emailError,
      passwordError: passwordError,
      shouldValidateEmail: shouldValidateEmail,
      shouldValidatePassword: shouldValidatePassword,
      success: success,
    );
  }

  LoginState copyWith({
    String emailError,
    String passwordError,
    bool shouldValidateEmail,
    bool shouldValidatePassword,
    bool success,
  }) {
    return LoginState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      shouldValidateEmail: shouldValidateEmail ?? this.shouldValidateEmail,
      shouldValidatePassword:
          shouldValidatePassword ?? this.shouldValidatePassword,
      success: success ?? this.success,
    );
  }

  @override
  List<Object> get props => [
        emailError,
        passwordError,
        shouldValidateEmail,
        shouldValidatePassword,
        success,
      ];
}
