import 'package:annatel_app/entities/geofence.dart';
import 'package:flutter/foundation.dart';

class Subscription {
  final String watchId;
  final String name;
  final List<Geofence> geofences;

  Subscription({
    @required this.watchId,
    @required this.name,
    @required this.geofences,
  });

  Subscription.fromJson(Map<String, dynamic> json)
      : watchId = json["watch"],
        name = json["name"],
        geofences = json["geofences"]
            .map((geofence) => Geofence.fromJson(geofence))
            .toList()
            .cast<Geofence>();
}
