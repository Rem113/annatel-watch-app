import 'dart:async';

import 'package:annatel_app/core/http_client.dart';
import 'package:annatel_app/core/token_manager.dart';
import 'package:annatel_app/entities/message.dart';
import 'package:annatel_app/services/watch_service.dart';
import 'package:bloc/bloc.dart';
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

    yield WatchState.loaded(result);
  }
}
