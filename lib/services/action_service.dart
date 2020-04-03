import 'package:annatel_app/core/failures.dart';
import 'package:annatel_app/entities/action.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../core/http_client.dart';

class ActionService {
  static const API_BASE = 'http://88.218.220.20:8000/api/action';

  final HTTPClient client;

  ActionService({
    @required this.client,
  });

  Future<Either<Failure, List<Action>>> getAllActions() async {
    try {
      final response = await client.get(API_BASE);
    } catch (e) {}
  }
}
