part of 'watch_bloc.dart';

@immutable
abstract class WatchEvent {}

class LoadMessages extends WatchEvent {
  final String watchId;

  LoadMessages(this.watchId);
}
