import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sendify/features/templates/domain/entity/template_entity.dart';
import 'package:sendify/features/templates/domain/usecase/get_templates.dart';
import 'package:sendify/features/templates/domain/usecase/send_notification_by_template_id.dart'
    as Notification;

part 'templates_event.dart';

part 'templates_state.dart';

class TemplatesBloc extends Bloc<TemplatesEvent, TemplatesState> {
  final GetTemplates _getTemplates;
  final Notification.SendNotificationByTemplateId _sendNotificationByTemplateId;

  TemplatesBloc(this._getTemplates, this._sendNotificationByTemplateId)
      : super(TemplatesInitial());

  int offset = 0;
  int limit = 20;
  int page;
  int totalPage;
  bool hasReachedMax = false;
  List<TemplateEntity> _list = [];

  @override
  Stream<TemplatesState> mapEventToState(
    TemplatesEvent event,
  ) async* {
    if (event is TemplatesEventLoadMore) {
      if (_list.length != 0) {
        yield TemplateLoading(_list);
      }
      final either = await _getTemplates(Params(offset));
      yield* either.fold(
        (l) async* {},
        (r) async* {
          _list.addAll(r.templates);

          offset += limit;
          totalPage = (r.totalCount / 10).ceil();
          page = (offset / 10).ceil();

          yield TemplatesLoaded(_list, totalPage <= page);
        },
      );
    } else if (event is TemplatesEventSendByID) {
      final either =
          await _sendNotificationByTemplateId(Notification.Params(event.id));
      yield* either.fold(
        (l) async* {
          yield TemplateFailedToSendNotification();
        },
        (r) async* {
          yield TemplateSuccessSendNotification();
        },
      );
    }
  }
}
