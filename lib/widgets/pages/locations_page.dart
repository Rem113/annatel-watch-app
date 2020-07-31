import 'package:annatel_app/blocs/subscription/subscription_bloc.dart';
import 'package:annatel_app/blocs/watch/watch_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  WatchBloc _watchBloc;
  SubscriptionBloc _subscriptionBloc;

  @override
  void initState() {
    super.initState();
    _subscriptionBloc = BlocProvider.of<SubscriptionBloc>(context);
    _watchBloc = WatchBloc();
    _watchBloc.add(LoadMessages(_subscriptionBloc.state.selectedWatch));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<WatchBloc, WatchState>(
          bloc: _watchBloc,
          builder: (context, state) {
            if (state.loading) {
              return Center(child: CircularProgressIndicator());
            } else {
              final messages = state.messages;
              final addresses = state.addresses;
              final locations = messages
                  .where((message) => ["UD", "AL"].contains(message.actionType))
                  .toList();

              DateFormat dateFormat = DateFormat('dd/MM/y HH:mm');

              return ListView.builder(
                  itemBuilder: (context, index) {
                    DateTime dt =
                        DateTime.parse(locations[index].payload['date']);

                    return ListTile(
                      title: Text(addresses[index]),
                      subtitle: Text(dateFormat.format(dt)),
                      leading: Text(
                        '${index + 1}.',
                        style: TextStyle(fontSize: 17),
                      ),
                    );
                  },
                  itemCount: locations.length);
            }
          },
        ),
      ),
    );
  }
}
