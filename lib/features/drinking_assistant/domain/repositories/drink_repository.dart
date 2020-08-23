import 'package:dartz/dartz.dart';
import 'package:drinking_assistant/core/error/failures.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/drink_history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/drink_history_entity.dart';

abstract class DrinkRepository {
  void initDrinkHistory(DrinkHistoryModel drinkHistoryToInit);

  Either<Failure, DrinkHistoryEntity> updateDrinkHistory(
      int key, DrinkHistoryModel drinkHistoryToUpdate);

  Either<Failure, List<DrinkHistoryEntity>> getDrinkHistory();
}
