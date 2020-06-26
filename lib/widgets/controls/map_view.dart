import 'package:annatel_app/entities/geofence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapView extends StatelessWidget {
  static const ACCESS_TOKEN =
      "pk.eyJ1IjoicmVtMTEzIiwiYSI6ImNrODdiNGt5NTBrYjYzb21td2U0bmRpNmcifQ.FnKRSZ3keM6IR_cymxIckw";

  final List<LatLng> locations;
  final List<Geofence> geofences;

  MapView({
    @required this.locations,
    @required this.geofences,
  });

  @override
  Widget build(BuildContext context) => FlutterMap(
        options: MapOptions(
          center: locations.isNotEmpty ? locations[0] : LatLng(0, 0),
          zoom: 15.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': ACCESS_TOKEN,
              'id': 'mapbox.streets'
            },
          ),
          CircleLayerOptions(
            circles: geofences
                .map((geofence) => CircleMarker(
                      point: LatLng(
                        geofence.latitude,
                        geofence.longitude,
                      ),
                      radius: geofence.radius,
                      useRadiusInMeter: true,
                      borderColor: Colors.blue,
                      borderStrokeWidth: 2.0,
                      color: Colors.lightBlue,
                    ))
                .toList(),
          ),
          PolylineLayerOptions(
            polylines: [
              Polyline(
                points: locations,
                borderColor: Theme.of(context).accentColor,
                borderStrokeWidth: 2.0,
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
          MarkerLayerOptions(
            markers: geofences
                .map(
                  (geofence) => Marker(
                    point: LatLng(
                      geofence.latitude,
                      geofence.longitude,
                    ),
                    width: 256.0,
                    height: 128.0,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 88.0,
                        ),
                        Text(
                          geofence.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            shadows: [
                              Shadow(
                                color: Colors.black38,
                                offset: Offset(2.0, 2.0),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          MarkerLayerOptions(
            markers: locations
                .asMap()
                .map(
                  (i, c) => MapEntry(
                    i,
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: c,
                      builder: (ctx) => CircleAvatar(
                        child: Text(
                          (i + 1).toString(),
                        ),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ],
      );
}
