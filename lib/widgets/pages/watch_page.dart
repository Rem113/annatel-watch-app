import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/add_watch/add_watch_bloc.dart';
import '../../blocs/watch/watch_bloc.dart';
import '../../entities/subscription.dart';
import '../../routes.dart';
import '../controls/add_watch_dialog.dart';

class WatchPage extends StatefulWidget {
  @override
  _WatchPageState createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  WatchBloc _watchBloc;

  @override
  void initState() {
    super.initState();

    _watchBloc = BlocProvider.of<WatchBloc>(context);
    _watchBloc.add(LoadSubscriptions());
  }

  Widget _buildSubscriptionList(List<Subscription> subscriptions) =>
      ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final sub = subscriptions[index];
          return ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text(sub.name),
            onTap: () => _watchBloc.add(WatchSelected(sub.watchId)),
          );
        },
      );

  _showAddWatchDialog(BuildContext context) async {
    final added = await showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (_) => AddWatchBloc(),
        child: AddWatchDialog(_scaffoldKey),
      ),
    );

    if (added != null) {
      _watchBloc.add(LoadSubscriptions());
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<WatchBloc, WatchState>(
        bloc: _watchBloc,
        listener: (context, state) {
          if (state.selectedWatch != null) {
            Navigator.of(context).pushNamed(MAP_PAGE);
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Watches"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, LOGIN_PAGE),
              ),
            ],
          ),
          body: BlocBuilder(
            bloc: _watchBloc,
            builder: (context, state) {
              if (state.loading == true) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.error != null) {
                return Center(
                  child: Text(state.error),
                );
              }

              return _buildSubscriptionList(state.subscriptions);
            },
          ),
          floatingActionButton: Builder(
            builder: (context) {
              return FloatingActionButton.extended(
                onPressed: () => _showAddWatchDialog(context),
                label: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(width: 8.0),
                    Text("Add Watch"),
                  ],
                ),
              );
            },
          ),
        ),
      );
}
