import 'package:annatel_app/core/failures.dart';
import 'package:annatel_app/core/http_client.dart';
import 'package:annatel_app/core/token_manager.dart';
import 'package:annatel_app/entities/subscription.dart';
import 'package:annatel_app/services/parent_service.dart';
import 'package:flutter/material.dart';

class WatchesPage extends StatefulWidget {
  @override
  _WatchesPageState createState() => _WatchesPageState();
}

class _WatchesPageState extends State<WatchesPage> {
  ParentService _parentService;

  @override
  void initState() {
    super.initState();

    _parentService =
        ParentService(client: HTTPClient(tokenManager: TokenManager()));
    _parentService.subscriptions();
  }

  Widget _buildSubscriptionList(List<Subscription> subscriptions) =>
      ListView.builder(
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subscriptions[index].watchId),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watches"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _parentService.subscriptions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data.fold(
            (failure) => Center(child: Text(failure.message)),
            (subscriptions) =>
                _buildSubscriptionList(subscriptions as List<Subscription>),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Row(
          children: <Widget>[
            Icon(Icons.add),
            SizedBox(width: 8.0),
            Text("Add Watch"),
          ],
        ),
      ),
    );
  }
}
