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
        error: error,
        loading: false,
      );

  WatchState copyWith({
    List<Subscription> subscriptions,
    String error,
    bool loading,
    String selectedWatch,
  }) {
    return WatchState(
      subscriptions: subscriptions ?? this.subscriptions,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      selectedWatch: selectedWatch ?? this.selectedWatch,
    );
  }
}
