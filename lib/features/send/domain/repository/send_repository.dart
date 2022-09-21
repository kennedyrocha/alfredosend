import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/features/send/domain/entity/send_result_entity.dart';

abstract class SendRepository {
  Future<Either<Failure, SendResultEntity>> send(
    String title,
    String content,
    String androidImageUrl,
    String iosAttachment,
  );
}
