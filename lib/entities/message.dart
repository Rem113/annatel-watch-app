import 'package:meta/meta.dart';

class Message {
  final int length;
  final String actionType;
  final Map<String, dynamic> payload;

  Message({
    @required this.length,
    @required this.actionType,
    @required this.payload,
  });

  Message.fromJson(Map<String, dynamic> json)
      : length = json["length"],
        actionType = json["type"],
        payload = json["payload"];
}
