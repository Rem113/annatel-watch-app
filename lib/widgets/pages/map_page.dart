import 'package:annatel_app/blocs/subscription/subscription_bloc.dart';
import 'package:annatel_app/blocs/watch/watch_bloc.dart';
import 'package:annatel_app/widgets/controls/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  WatchBloc _watchBloc;
  SubscriptionBloc _subscriptionBloc;

  int _focusIndex = 0;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();

    _subscriptionBloc = BlocProvider.of<SubscriptionBloc>(context);
    _watchBloc = BlocProvider.of<WatchBloc>(context);
    _watchBloc.add(LoadMessages(_subscriptionBloc.state.selectedWatch));
  }

  _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.location_on),
                    SizedBox(height: 8.0),
                    Text(
                      "Location",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
              ),
              FlatButton(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.gps_not_fixed),
                    SizedBox(height: 8.0),
                    Text(
                      "Geofence",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
              ),
              FlatButton(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.settings),
                    SizedBox(height: 8.0),
                    Text(
                      "Settings",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  _moveMap(int index) {
    final locations = _watchBloc.state.messages
        .where((message) => message.actionType == "UD")
        .toList();
    if (index >= 0 && index < locations.length) {
      final center = locations[index];
      _mapController.move(
        LatLng(
          center.payload["latitude"].toDouble(),
          center.payload["longitude"].toDouble(),
        ),
        15.0,
      );

      setState(() {
        _focusIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<WatchBloc, WatchState>(
          bloc: _watchBloc,
          builder: (context, state) {
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            } else {
              final messages = state.messages;
              final locations = messages
                  .where((message) => message.actionType == "UD")
                  .toList();

              return MapView(
                mapController: _mapController,
                locations: locations
                    .map(
                      (location) => LatLng(
                        location.payload["latitude"].toDouble(),
                        location.payload["longitude"].toDouble(),
                      ),
                    )
                    .toList(),
                geofences: _subscriptionBloc.state.subscriptions
                    .firstWhere((sub) =>
                        sub.watchId == _subscriptionBloc.state.selectedWatch)
                    .geofences,
              );
            }
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => _moveMap(_focusIndex - 1),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => _moveMap(_focusIndex + 1),
              ),
            ],
          ),
        ),
        extendBody: true,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.menu),
            onPressed: () => _showMenu(context),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}
