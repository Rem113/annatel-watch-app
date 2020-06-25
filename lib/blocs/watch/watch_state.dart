part of 'watch_bloc.dart';

class WatchState {
  final List<Subscription> subscriptions;
  final String error;
  final bool loading;
  final String selectedWatch;

  WatchState({
    this.subscriptions,
    this.error,
    this.loading,
    this.selectedWatch,
  });

  factory WatchState.init() => WatchState(
        subscriptions: [],
        error: null,
        loading: false,
        selectedWatch: null,
      );

  factory WatchState.loading() => WatchState(
        subscriptions: [],
        error: null,
        loading: true,
        selectedWatch: null,
      );

  factory WatchState.loaded(List<Subscription> subscriptions) => WatchState(
        subscriptions: subscriptions,
        error: null,
        loading: false,
        selectedWatch: null,
      );

  factory WatchState.error(String error) => WatchState(
        subscriptions: [],
        error: error,
        loading: false,
        selectedWatch: null,
      );

  factory WatchState.watchSelected(String watchId) => WatchState(
        subscriptions: [],
        error: null,
        loading: false,
        selectedWatch: watchId,
      );
}
