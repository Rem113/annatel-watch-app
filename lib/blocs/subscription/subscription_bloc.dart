import 'dart:async';

import 'package:annatel_app/core/http_client.dart';
import 'package:annatel_app/core/token_manager.dart';
import 'package:annatel_app/entities/subscription.dart';
import 'package:annatel_app/services/parent_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  @override
  SubscriptionState get initialState => SubscriptionState.init();

  @override
  Stream<SubscriptionState> mapEventToState(
    SubscriptionEvent event,
  ) async* {
    if (event is LoadSubscriptions) {
      yield* _mapLoadSubscriptionsToState(event);
    } else if (event is WatchSelected) {
      yield* _mapWatchSelectedToState(event);
    }
  }

  Stream<SubscriptionState> _mapLoadSubscriptionsToState(
      LoadSubscriptions event) async* {
    yield SubscriptionState.loading();

    final tokenManager = TokenManager();
    final httpClient = HTTPClient(tokenManager: tokenManager);
    final parentService = ParentService(client: httpClient);

    final subscriptions = await parentService.subscriptions();

    yield subscriptions.fold(
      (failure) => SubscriptionState.error(failure.message),
      (subscriptions) => SubscriptionState.loaded(subscriptions),
    );
  }

  Stream<SubscriptionState> _mapWatchSelectedToState(
      WatchSelected event) async* {
    yield state.copyWith(selectedWatch: event.watchId);
  }
}
