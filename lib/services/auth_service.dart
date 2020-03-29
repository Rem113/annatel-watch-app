import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../core/failures.dart';
import '../core/http_client.dart';
import '../core/token_manager.dart';

class AuthService {
  static const API_BASE = 'http://88.218.220.20:8000/api';

  final TokenManager tokenManager;
  final HTTPClient client;

  AuthService({
    @required this.tokenManager,
    @required this.client,
  });

  Future<Option<AuthFailure>> login({
    @required String email,
    @required String password,
  }) async {
    try {
      final response = await client.post(
        API_BASE + '/auth/login',
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode != 200) return Some(AuthFailure(body["errors"]));

      await tokenManager.setToken(body["payload"]["token"]);
      return None();
    } catch (e) {
      return Some(AuthFailure(e.toString()));
    }
  }
}
