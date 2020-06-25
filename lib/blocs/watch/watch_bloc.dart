import 'dart:async';

import 'package:annatel_app/core/http_client.dart';
import 'package:annatel_app/core/token_manager.dart';
import 'package:annatel_app/entities/subscription.dart';
import 'package:annatel_app/services/parent_service.dart';
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
    if (event is LoadSubscriptions) {
      yield* _mapLoadSubscriptionsToState(event);
    }
  }

  Stream<WatchState> _mapLoadSubscriptionsToState(
      LoadSubscriptions event) async* {
    yield WatchState.loading();

    final tokenManager = TokenManager();
    final httpClient = HTTPClient(tokenManager: tokenManager);
    final parentService = ParentService(client: httpClient);

    final subscriptions = await parentService.subscriptions();

    yield subscriptions.fold(
      (failure) => WatchState.error(failure.message),
      (subscriptions) => WatchState.loaded(subscriptions),
    );
  }
}
