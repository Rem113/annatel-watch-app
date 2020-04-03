abstract class Failure {
  final String message;
  final Map<String, dynamic> payload;

  Failure({
    this.message,
    this.payload,
  });
}

class AuthFailure extends Failure {
  AuthFailure({
    String message,
    Map<String, dynamic> payload,
  }) : super(
          message: message,
          payload: payload,
        );
}
