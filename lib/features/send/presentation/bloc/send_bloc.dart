import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sendify/features/send/domain/entity/send_result_entity.dart';
import 'package:sendify/features/send/domain/usecase/send.dart';

part 'send_event.dart';

part 'send_state.dart';

class SendBloc extends Bloc<SendEvent, SendState> {
  final Send _send;

  SendBloc(this._send) : super(SendInitial());

  @override
  Stream<SendState> mapEventToState(
    SendEvent event,
  ) async* {
    if (event is SendNotificationEvent) {
      yield SendLoadingState();
      final either = await _send(
        Params(
          event.title,
          event.content,
          event.androidImageUrl,
          event.iosAttachment,
        ),
      );

      yield* either.fold(
        (l) async* {
          yield SendErrorResultState();
        },
        (r) async* {
          yield SendSuccessResultState(r);
        },
      );
    }
  }
}
