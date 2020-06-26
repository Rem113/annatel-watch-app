import 'package:annatel_app/entities/time_frame.dart';
import 'package:flutter/foundation.dart';

class Geofence {
  final double latitude;
  final double longitude;
  final double radius;
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
      : latitude = json["latitude"].toDouble(),
        longitude = json["longitude"].toDouble(),
        radius = json["radius"].toDouble(),
        name = json["name"],
        notifications = json["notification"],
        timeFrames = json["time_frames"]
            .map((tf) => TimeFrame.fromJson(tf))
            .toList()
            .cast<TimeFrame>();
}
