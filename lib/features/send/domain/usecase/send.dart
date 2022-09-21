import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/core/interactor/usecase.dart';
import 'package:sendify/features/send/domain/entity/send_result_entity.dart';
import 'package:sendify/features/send/domain/repository/send_repository.dart';

class Send extends UseCase<SendResultEntity, Params> {
  final SendRepository _sendRepository;

  Send(this._sendRepository);

  @override
  Future<Either<Failure, SendResultEntity>> call(Params params) =>
      _sendRepository.send(
        params.title,
        params.content,
        params.androidImageUrl,
        params.iosAttachment,
      );
}

class Params {
  final String title;

  final String content;

  final String androidImageUrl;

  final String iosAttachment;

  Params(this.title, this.content, this.androidImageUrl, this.iosAttachment);
}
