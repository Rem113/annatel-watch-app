import 'package:annatel_app/core/failures.dart';
import 'package:annatel_app/entities/message.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../core/http_client.dart';

class WatchService {
  static const API_BASE = 'http://88.218.220.20:8000/api/watch';

  final HTTPClient client;

  WatchService({
    @required this.client,
  });

  Future<Either<Failure, List<Message>>> getMessages(String watchId) async {
    final response = await client.get('$API_BASE/$watchId/messages');
  }
}
