part of 'watch_bloc.dart';

class WatchState {
  final List<Message> messages;
  final List<String> addresses;
  final bool loading;

  WatchState({
    this.messages,
    this.loading,
    this.addresses,
  });

  factory WatchState.init() =>
      WatchState(messages: [], loading: false, addresses: []);

  factory WatchState.loading() =>
      WatchState(messages: [], loading: true, addresses: []);

  factory WatchState.loaded(List<Message> messages, List<String> addresses) =>
      WatchState(
        messages: messages,
        loading: false,
        addresses: addresses,
      );
}
