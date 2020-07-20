import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../core/failures.dart';
import '../core/http_client.dart';
import '../core/token_manager.dart';

class AccountService {
  static const API_BASE = 'http://88.218.220.20:3000/api/account';

  final TokenManager tokenManager;
  final HTTPClient client;

  AccountService({
    @required this.tokenManager,
    @required this.client,
  });

  Future<Option<Failure>> login({
    @required String email,
    @required String password,
  }) async {
    final response = await client.post(
      "$API_BASE/token",
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode != HttpStatus.ok)
      return Some(
        AuthFailure(message: body["message"]),
      );

    await tokenManager.setToken(body["token"]);
    return None();
  }

  Future<Option<Failure>> register({
    @required String email,
    @required String password,
  }) async {
    final response = await client.post(
      '$API_BASE',
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode != HttpStatus.created)
      return Some(
        AuthFailure(message: body["message"]),
      );

    await login(email: email, password: password);

    return None();
  }
}
