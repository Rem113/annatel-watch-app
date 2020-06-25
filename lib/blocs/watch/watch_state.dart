part of 'watch_bloc.dart';

class WatchState {
  final List<Message> messages;
  final bool loading;

  WatchState({
    this.messages,
    this.loading,
  });

  factory WatchState.init() => WatchState(
        messages: [],
        loading: false,
      );

  factory WatchState.loading() => WatchState(
        messages: [],
        loading: true,
      );

  factory WatchState.loaded(List<Message> messages) => WatchState(
        messages: messages,
        loading: false,
      );
}
