import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/core/interactor/usecase.dart';
import 'package:sendify/features/templates/domain/entity/template_entity.dart';
import 'package:sendify/features/templates/domain/repository/templates_repository.dart';

class GetTemplates extends UseCase<TemplatesEntity, Params> {

  final TemplatesRepository _repository;

  GetTemplates(this._repository);

  @override
  Future<Either<Failure, TemplatesEntity>> call(Params params) async => _repository.getTemplates(params.offset);


}


class Params {
  final int offset;

  Params(this.offset);
}