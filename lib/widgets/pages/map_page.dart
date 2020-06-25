import 'package:annatel_app/blocs/subscription/subscription_bloc.dart';
import 'package:annatel_app/blocs/watch/watch_bloc.dart';
import 'package:annatel_app/widgets/controls/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  WatchBloc _watchBloc;
  SubscriptionBloc _subscriptionBloc;

  @override
  void initState() {
    super.initState();

    _subscriptionBloc = BlocProvider.of<SubscriptionBloc>(context);
    _watchBloc = BlocProvider.of<WatchBloc>(context);
    _watchBloc.add(LoadMessages(_subscriptionBloc.state.selectedWatch));
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
                locations
                    .map(
                      (location) => LatLng(
                        location.payload["latitude"].toDouble(),
                        location.payload["longitude"].toDouble(),
                      ),
                    )
                    .toList(),
              );
            }
          },
        ),
      );
}
