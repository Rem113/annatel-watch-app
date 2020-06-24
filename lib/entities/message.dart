import 'package:meta/meta.dart';

class Message {
  final String id;
  final String vendor;
  final int length;
  final String watchId;
  final String actionType;
  final Map<String, dynamic> payload;

  Message({
    @required this.id,
    @required this.vendor,
    @required this.length,
    @required this.watchId,
    @required this.actionType,
    this.payload = const {},
  });
}
