import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/add_watch/add_watch_bloc.dart';
import '../../blocs/subscription/subscription_bloc.dart';
import '../../entities/subscription.dart';
import '../../routes.dart';
import '../controls/add_watch_dialog.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SubscriptionBloc _subscriptionBloc;

  @override
  void initState() {
    super.initState();

    _subscriptionBloc = BlocProvider.of<SubscriptionBloc>(context);
    _subscriptionBloc.add(LoadSubscriptions());
  }

  Widget _buildSubscriptionList(List<Subscription> subscriptions) =>
      ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          final sub = subscriptions[index];
          return ListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text(sub.name),
            onTap: () => _subscriptionBloc.add(WatchSelected(sub.watchId)),
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
      _subscriptionBloc.add(LoadSubscriptions());
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<SubscriptionBloc, SubscriptionState>(
        bloc: _subscriptionBloc,
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
            bloc: _subscriptionBloc,
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

              if (state.subscriptions.length == 0) {
                return Center(child: Text("You have no subscriptions yet!"));
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
