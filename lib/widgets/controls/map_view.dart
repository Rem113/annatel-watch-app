import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapView extends StatelessWidget {
  static const ACCESS_TOKEN =
      "pk.eyJ1IjoicmVtMTEzIiwiYSI6ImNrODdiNGt5NTBrYjYzb21td2U0bmRpNmcifQ.FnKRSZ3keM6IR_cymxIckw";

  final List<LatLng> coordinates;

  MapView(this.coordinates);

  @override
  Widget build(BuildContext context) => FlutterMap(
        options: MapOptions(
          center: coordinates.isNotEmpty ? coordinates[0] : LatLng(0, 0),
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
          PolylineLayerOptions(
            polylines: [
              Polyline(
                points: coordinates,
                borderColor: Theme.of(context).accentColor,
                borderStrokeWidth: 2.0,
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
          MarkerLayerOptions(
            markers: coordinates
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
