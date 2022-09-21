import 'package:dartz/dartz.dart';
import 'package:sendify/core/error/exceptions.dart';
import 'package:sendify/core/error/failures.dart';

abstract class RepositoryTaskIsolator {
  Future<Either<Failure, T>> isolateTask<T>(Future<T> Function() task) async {
    try {
      final result = await task();
      return Right(result);
    } on ServerException catch (ex) {
      return Left(ServerFailure());
    }
  }
}