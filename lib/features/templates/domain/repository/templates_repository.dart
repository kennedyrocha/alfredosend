import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/core/repository/repository_task_isolator.dart';
import 'package:sendify/core/utils/nothing.dart';
import 'package:sendify/features/templates/domain/entity/template_entity.dart';

abstract class TemplatesRepository extends RepositoryTaskIsolator {
  Future<Either<Failure, TemplatesEntity>> getTemplates(int offset);
  Future<Either<Failure, Nothing>> sendNotificationByTemplate(String notificationId);
}
