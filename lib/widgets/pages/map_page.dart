import 'package:annatel_app/widgets/controls/map_view.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: MapView(
          [
            LatLng(48.83332, 2.4955),
            LatLng(48.84, 2.49),
            LatLng(48.84, 2.5),
          ],
        ),
      );
}
