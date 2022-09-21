import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/failures.dart';
import 'package:sendify/features/send/data/datasource/send_remote_datasource.dart';
import 'package:sendify/features/send/domain/entity/send_result_entity.dart';
import 'package:sendify/features/send/domain/repository/send_repository.dart';

class SendRepositoryImpl extends SendRepository {
  final SendRemoteDataSource _sendRemoteDataSource;

  SendRepositoryImpl(this._sendRemoteDataSource);

  @override
  Future<Either<Failure, SendResultEntity>> send(String title, String content,
      String androidImageUrl, String iosAttachment) async {
    try {
      final result = await _sendRemoteDataSource.send(
          title, content, androidImageUrl, iosAttachment);
      return Right(result);
    } catch (ex) {
      return Left(ServerFailure());
    }
  }
}
