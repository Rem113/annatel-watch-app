import 'dart:convert';

import 'package:annatel_app/entities/message.dart';
import 'package:meta/meta.dart';

import '../core/http_client.dart';

class WatchService {
  static const API_BASE = 'http://88.218.220.20:3000/api/watch';

  final HTTPClient client;

  WatchService({
    @required this.client,
  });

  Future<List<Message>> messagesFor(String watchId) async {
    final response = await client.get('$API_BASE/$watchId/messages');

    final body = jsonDecode(response.body);

    final messages = body["messages"]
        .map((message) => Message.fromJson(message))
        .toList()
        .cast<Message>();

    return messages;
  }
}
