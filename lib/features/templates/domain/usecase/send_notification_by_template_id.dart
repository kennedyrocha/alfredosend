import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/core/interactor/usecase.dart';
import 'package:sendify/core/utils/nothing.dart';
import 'package:sendify/features/templates/domain/repository/templates_repository.dart';

class SendNotificationByTemplateId extends UseCase<Nothing, Params>{
  final TemplatesRepository _templatesRepository;

  SendNotificationByTemplateId(this._templatesRepository);

  @override
  Future<Either<Failure, Nothing>> call(Params params) =>  _templatesRepository.sendNotificationByTemplate(params.id);
}

class Params{
  final String id;

  Params(this.id);
}