abstract class Failure {}

class AuthFailure {
  final Object errors;

  AuthFailure(this.errors);
}
