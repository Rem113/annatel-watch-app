import 'package:annatel_app/entities/time_frame.dart';
import 'package:flutter/foundation.dart';

class Geofence {
  final num latitude;
  final num longitude;
  final num radius;
  final String name;
  final bool notifications;
  final List<TimeFrame> timeFrames;

  Geofence({
    @required this.latitude,
    @required this.longitude,
    @required this.radius,
    @required this.name,
    @required this.notifications,
    @required this.timeFrames,
  });

  Geofence.fromJson(Map<String, dynamic> json)
      : latitude = json["latitude"],
        longitude = json["longitude"],
        radius = json["radius"],
        name = json["name"],
        notifications = json["notification"],
        timeFrames = json["time_frames"]
            .map((tf) => TimeFrame.fromJson(tf))
            .toList()
            .cast<TimeFrame>();
}
