import 'package:dartz/dartz.dart';
import 'package:drinking_assistant/core/error/failures.dart';
import 'package:drinking_assistant/core/usecases/usecase.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/drink_history_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/repositories/drink_repository.dart';

class GetDrinkHistory extends Usecase<List<DrinkHistoryEntity>, NoParams> {
  DrinkRepository repository;

  GetDrinkHistory(this.repository);

  @override
  Future<Either<Failure, List<DrinkHistoryEntity>>> call(NoParams params) {
    return Future.value(repository.getDrinkHistory());
  }

}
