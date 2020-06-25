import 'dart:async';

import 'package:annatel_app/core/http_client.dart';
import 'package:annatel_app/core/token_manager.dart';
import 'package:annatel_app/core/validators.dart';
import 'package:annatel_app/services/parent_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_watch_event.dart';
part 'add_watch_state.dart';

class AddWatchBloc extends Bloc<AddWatchEvent, AddWatchState> {
  @override
  AddWatchState get initialState => AddWatchState.init();

  @override
  Stream<AddWatchState> mapEventToState(
    AddWatchEvent event,
  ) async* {
    if (event is AddWatchAttempt) yield* _mapAddWatchAttemptToState(event);
  }

  Stream<AddWatchState> _mapAddWatchAttemptToState(
      AddWatchAttempt event) async* {
    final nameError = Validators.validateWatchName(event.name);
    final idError = Validators.validateWatchId(event.id);
    final vendorError = Validators.validateWatchVendor(event.vendor);

    if (nameError != null || idError != null || vendorError != null) {
      yield AddWatchState.error(nameError, idError, vendorError, null);
      return;
    }

    yield AddWatchState.submitting();

    final tokenManager = TokenManager();
    final httpClient = HTTPClient(tokenManager: tokenManager);
    final parentService = ParentService(client: httpClient);

    final result =
        await parentService.subscribeTo(event.name, event.id, event.vendor);

    yield result.fold(
      () => AddWatchState.added(),
      (failure) => AddWatchState.error(null, null, null, failure.message),
    );
  }
}
