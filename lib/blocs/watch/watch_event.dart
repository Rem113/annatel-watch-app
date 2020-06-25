part of 'watch_bloc.dart';

@immutable
abstract class WatchEvent {}

class LoadSubscriptions extends WatchEvent {}

class SelectWatch extends WatchEvent {
  final String watchId;

  SelectWatch({@required this.watchId});
}
