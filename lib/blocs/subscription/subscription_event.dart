part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionEvent {}

class LoadSubscriptions extends SubscriptionEvent {}

class WatchSelected extends SubscriptionEvent {
  final String watchId;

  WatchSelected(this.watchId);
}
