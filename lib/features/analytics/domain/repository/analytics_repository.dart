import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/core/repository/repository_task_isolator.dart';
import 'package:sendify/features/analytics/domain/entity/analytics_entity.dart';

abstract class AnalyticsRepository extends RepositoryTaskIsolator {
  Future<Either<Failure, AnalyticsResponseEntity>> getNotifications(int offset);
}