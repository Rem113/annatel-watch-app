part of 'subscription_bloc.dart';

class SubscriptionState {
  final List<Subscription> subscriptions;
  final String error;
  final bool loading;
  final String selectedWatch;

  SubscriptionState({
    this.subscriptions,
    this.error,
    this.loading,
    this.selectedWatch,
  });

  factory SubscriptionState.init() => SubscriptionState(
        subscriptions: [],
        error: null,
        loading: false,
        selectedWatch: null,
      );

  factory SubscriptionState.loading() => SubscriptionState(
        subscriptions: [],
        error: null,
        loading: true,
        selectedWatch: null,
      );

  factory SubscriptionState.loaded(List<Subscription> subscriptions) =>
      SubscriptionState(
        subscriptions: subscriptions,
        error: null,
        loading: false,
        selectedWatch: null,
      );

  factory SubscriptionState.error(String error) => SubscriptionState(
        error: error,
        loading: false,
      );

  SubscriptionState copyWith({
    List<Subscription> subscriptions,
    String error,
    bool loading,
    String selectedWatch,
  }) {
    return SubscriptionState(
      subscriptions: subscriptions ?? this.subscriptions,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      selectedWatch: selectedWatch ?? this.selectedWatch,
    );
  }
}
