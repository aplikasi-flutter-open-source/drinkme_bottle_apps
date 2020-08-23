import 'package:dartz/dartz.dart';
import 'package:drinking_assistant/core/error/exception.dart';
import 'package:drinking_assistant/core/error/failures.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/data_sources/bottle_remote_data_source.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/bottle_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/repositories/bottle_repository.dart';
import 'package:meta/meta.dart';

class BottleRepositoryImpl implements BottleRepository {
  final BottleRemoteDataSource remoteDataSource;

//  final NetworkInfo networkInfo;

  BottleRepositoryImpl({
    @required this.remoteDataSource,
//    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, BottleEntity>> authenticateBottle(
      int bottleCode) async {
    try {
      final bottle = await remoteDataSource.authenticateBottle(bottleCode);
      return Right(bottle);
    } on ServerException {
      return Left(ServerFailure());
    } on BottleException catch (e) {
      return Left(BottleFailure(e.message));
    }
  }
}
