import 'dart:async';

import 'package:annatel_app/core/http_client.dart';
import 'package:annatel_app/core/token_manager.dart';
import 'package:annatel_app/entities/message.dart';
import 'package:annatel_app/services/watch_service.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'watch_event.dart';
part 'watch_state.dart';

class WatchBloc extends Bloc<WatchEvent, WatchState> {
  @override
  WatchState get initialState => WatchState.init();

  @override
  Stream<WatchState> mapEventToState(
    WatchEvent event,
  ) async* {
    if (event is LoadMessages) yield* _mapLoadMessagesToState(event);
  }

  Stream<WatchState> _mapLoadMessagesToState(LoadMessages event) async* {
    final tokenManager = TokenManager();
    final httpClient = HTTPClient(tokenManager: tokenManager);
    final watchService = WatchService(client: httpClient);

    yield WatchState.loading();

    final result = await watchService.messagesFor(event.watchId);
    final addresses = await _getAddresses(result);

    yield WatchState.loaded(result, addresses);
  }

  Future<List<String>> _getAddresses(List<Message> messages) async {
    Geolocator geolocator = Geolocator();
    List<String> listAddresses = [];

    final locations = messages
        .where((message) => ["UD", "AL"].contains(message.actionType))
        .toList();

    for (var location in locations) {
      var result = await geolocator.placemarkFromCoordinates(
          location.payload['latitude'], location.payload['longitude']);

      var f = result.first;
      listAddresses.add("${f.name} ${f.thoroughfare} ${f.locality}");
    }

    return listAddresses;
  }
}
