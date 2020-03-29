import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const _TOKEN_KEY = 'annatel_app_token';
  static final _instance = TokenManager._internal();

  TokenManager._internal();

  factory TokenManager() {
    return _instance;
  }

  Future<void> setToken(String token) {
    // final storage = FlutterSecureStorage();

    // return storage.write(
    //   key: _TOKEN_KEY,
    //   value: token,
    // );
  }

  Future<String> getToken() {
    // final storage = FlutterSecureStorage();

    // return storage.read(key: _TOKEN_KEY);
  }
}
