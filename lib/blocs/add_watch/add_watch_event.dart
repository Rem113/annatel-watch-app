part of 'add_watch_bloc.dart';

@immutable
abstract class AddWatchEvent {}

class AddWatchAttempt extends AddWatchEvent {
  final String name;
  final String id;
  final String vendor;

  AddWatchAttempt({
    @required this.name,
    @required this.id,
    @required this.vendor,
  });
}
