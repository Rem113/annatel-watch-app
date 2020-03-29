import 'package:annatel_app/core/http_client.dart';
import 'package:annatel_app/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHTTPClient extends Mock implements HTTPClient {}

final tInvalidEmail = "invalidemail";
final tValidEmail = "remi.saal@gmail.com";
final tValidPassword = "password";

HTTPClient client;
AuthService authService;

void main() {
  setUp(() {
    client = MockHTTPClient();
    // authService = AuthService(client: client);
  });

  group("login", () {
    test("should return a failure when the user does not exist", () {
      // Arrange
      // when(client.login(email: ));

      // Act
      authService.login(email: tInvalidEmail, password: tValidPassword);
    });
    test("should return a failure when the password is invalid", () {});
    test("should store the token when the credentials are valid", () {});
  });
}
