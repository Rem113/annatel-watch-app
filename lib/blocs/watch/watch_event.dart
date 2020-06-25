part of 'watch_bloc.dart';

@immutable
abstract class WatchEvent {}

class LoadSubscriptions extends WatchEvent {}

class WatchSelected extends WatchEvent {
  final String watchId;

  WatchSelected(this.watchId);
}
