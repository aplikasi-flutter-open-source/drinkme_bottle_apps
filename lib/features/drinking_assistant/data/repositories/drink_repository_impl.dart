import 'package:dartz/dartz.dart';
import 'package:drinking_assistant/core/error/exception.dart';
import 'package:drinking_assistant/core/error/failures.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/data_sources/drink_history_local_data_source.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/drink_history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/drink_history_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/repositories/drink_repository.dart';
import 'package:meta/meta.dart';

class DrinkRepositoryImpl implements DrinkRepository {
//  final UserRemoteDataSource remoteDataSource;
//  final NetworkInfo networkInfo;
  final DrinkHistoryLocalDataSource localDataSource;

  DrinkRepositoryImpl({
//    @required this.remoteDataSource,
    @required this.localDataSource,
//    @required this.networkInfo,
  });

  @override
  Either<Failure, List<DrinkHistoryEntity>> getDrinkHistory() {
    try {
      final drinkHistory = localDataSource.getDrinkHistory();
      return Right(drinkHistory);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  void initDrinkHistory(DrinkHistoryModel historyToInit) {
    localDataSource.initDrinkHistory(historyToInit);
  }

  @override
  Either<Failure, DrinkHistoryEntity> updateDrinkHistory(
      int key, DrinkHistoryModel drinkHistoryToUpdate) {
    try {
      final drinkHistory = localDataSource.updateDrinkHistory(key, drinkHistoryToUpdate);
      return Right(drinkHistory);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
