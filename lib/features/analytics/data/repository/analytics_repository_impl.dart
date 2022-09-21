import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/features/analytics/data/datasource/analytics_remote_datasource.dart';
import 'package:sendify/features/analytics/domain/entity/analytics_entity.dart';
import 'package:sendify/features/analytics/domain/repository/analytics_repository.dart';

class AnalyticsRepositoryImpl extends AnalyticsRepository {
  final AnalyticsRemoteDataSource _analyticsRemoteDataSource;

  AnalyticsRepositoryImpl(this._analyticsRemoteDataSource);

  @override
  Future<Either<Failure, AnalyticsResponseEntity>> getNotifications(
          int offset) async =>
      isolateTask<AnalyticsResponseEntity>(
        () async => await _analyticsRemoteDataSource.getNotifications(offset),
      );
}
