part of 'add_watch_bloc.dart';

class AddWatchState {
  final String nameError;
  final String idError;
  final String vendorError;
  final String serverError;
  final bool submitting;
  final bool added;

  AddWatchState({
    @required this.nameError,
    @required this.idError,
    @required this.vendorError,
    @required this.serverError,
    @required this.submitting,
    @required this.added,
  });

  factory AddWatchState.init() => AddWatchState(
        nameError: null,
        idError: null,
        vendorError: null,
        serverError: null,
        submitting: false,
        added: false,
      );

  factory AddWatchState.submitting() => AddWatchState(
        nameError: null,
        idError: null,
        vendorError: null,
        serverError: null,
        submitting: true,
        added: false,
      );

  factory AddWatchState.added() => AddWatchState(
        nameError: null,
        idError: null,
        vendorError: null,
        serverError: null,
        submitting: false,
        added: true,
      );

  factory AddWatchState.error(
    String nameError,
    String idError,
    String vendorError,
    String serverError,
  ) =>
      AddWatchState(
        nameError: nameError,
        idError: idError,
        vendorError: vendorError,
        serverError: serverError,
        submitting: false,
        added: false,
      );
}
