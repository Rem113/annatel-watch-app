import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'token_manager.dart';

class HTTPClient {
  final TokenManager tokenManager;

  HTTPClient({
    @required this.tokenManager,
  });

  Future<http.Response> get(
    url, {
    Map<String, String> headers,
  }) async {
    final token = await tokenManager.getToken();
    headers[HttpHeaders.authorizationHeader] = 'Bearer $token';

    return http.get(
      url,
      headers: headers,
    );
  }

  Future<http.Response> post(
    url, {
    Map<String, String> headers,
    body,
    Encoding encoding,
  }) async {
    final token = await tokenManager.getToken();
    headers[HttpHeaders.authorizationHeader] = token;

    return http.post(
      url,
      headers: headers,
      body: body,
    );
  }
}
