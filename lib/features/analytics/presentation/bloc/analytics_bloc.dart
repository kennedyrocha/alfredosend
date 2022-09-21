import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sendify/features/analytics/domain/entity/analytics_entity.dart';
import 'package:sendify/features/analytics/domain/usecase/get_notifications.dart';

part 'analytics_event.dart';

part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetNotifications _getNotifications;

  AnalyticsBloc(this._getNotifications) : super(AnalyticsInitial());

  int offset = 0;
  int limit = 10;
  int page;
  int totalPage;
  bool hasReachedMax = false;
  List<AnalyticsEntity> _list = [];


  @override
  Stream<AnalyticsState> mapEventToState(
    AnalyticsEvent event,
  ) async* {
    if (event is AnalyticsEventLoadMore) {
      if(_list.length != 0){
        yield AnalyticsLoading(_list);
      }
      final either = await _getNotifications(Params(offset));
      yield* either.fold(
        (l) async* {},
        (r) async* {
          _list.addAll(r.list);

          offset += limit;
          totalPage = (r.totalCount / 10).ceil();
          page = (offset / 10).ceil();

          yield AnalyticsLoadedNotifications(_list, totalPage <= page);
        },
      );
    }
  }

}
