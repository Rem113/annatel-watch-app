part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessful extends RegisterState {
  final String token;

  RegisterSuccessful({
    @required this.token,
  });

  @override
  List<Object> get props => [token];
}

class RegisterError extends RegisterState {
  final Map<String, String> errors;

  RegisterError({
    @required this.errors,
  });

  @override
  List<Object> get props => [errors];
}
