import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../core/failures.dart';
import '../core/http_client.dart';
import '../entities/subscription.dart';

class ParentService {
  static const API_BASE = 'http://88.218.220.20:3000/api/parent';

  final HTTPClient client;

  ParentService({
    @required this.client,
  });

  Future<Either<Failure, List<Subscription>>> subscriptions() async {
    final response = await client.get('$API_BASE/subscriptions');

    if (response.statusCode != HttpStatus.ok) {
      return Left(AuthFailure(message: "An error has occurred"));
    }

    final body = jsonDecode(response.body);

    final subscriptions = body["subscriptions"]
        .map((sub) => Subscription.fromJson(sub))
        .toList()
        .cast<Subscription>();

    return Right(subscriptions);
  }

  Future<Option<Failure>> subscribeTo(
      String name, String id, String vendor) async {
    final response = await client.put(
      '$API_BASE/watch/subscribe',
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.value,
      },
      body: jsonEncode({
        "name": name,
        "serial": id,
        "vendor": vendor,
      }),
    );

    if (response.statusCode != HttpStatus.ok) {
      final body = jsonDecode(response.body);
      return Some(AuthFailure(message: body["message"]));
    }

    return None();
  }
}
