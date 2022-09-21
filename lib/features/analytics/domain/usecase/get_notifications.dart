import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/core/interactor/usecase.dart';
import 'package:sendify/features/analytics/domain/entity/analytics_entity.dart';
import 'package:sendify/features/analytics/domain/repository/analytics_repository.dart';

class GetNotifications extends UseCase<AnalyticsResponseEntity, Params> {
  final AnalyticsRepository _analyticsRepository;

  GetNotifications(this._analyticsRepository);

  @override
  Future<Either<Failure, AnalyticsResponseEntity>> call(Params params) =>
      _analyticsRepository.getNotifications(params.offset);
}

class Params {
  final int offset;

  Params(this.offset);
}
