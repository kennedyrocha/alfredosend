import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/core/utils/nothing.dart';
import 'package:sendify/features/templates/data/datasource/templates_remote_datasource.dart';
import 'package:sendify/features/templates/domain/entity/template_entity.dart';
import 'package:sendify/features/templates/domain/repository/templates_repository.dart';

class TemplatesRepositoryImpl extends TemplatesRepository {
  final TemplatesRemoteDataSource _dataSource;

  TemplatesRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, TemplatesEntity>> getTemplates(int offset) async =>
      isolateTask<TemplatesEntity>(
        () => _dataSource.getTemplates(offset),
      );

  @override
  Future<Either<Failure, Nothing>> sendNotificationByTemplate(
          String notificationId) =>
      isolateTask<Nothing>(
        () => _dataSource.sendNotificationByTemplate(notificationId),
      );
}
