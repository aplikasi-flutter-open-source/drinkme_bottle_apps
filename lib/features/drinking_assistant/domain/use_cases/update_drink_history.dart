import 'package:dartz/dartz.dart';
import 'package:drinking_assistant/core/error/failures.dart';
import 'package:drinking_assistant/core/usecases/usecase.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/drink_history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/drink_history_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/repositories/drink_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UpdateDrinkHistory
    extends Usecase<DrinkHistoryEntity, UpdateDrinkHistoryParams> {
  DrinkRepository repository;

  UpdateDrinkHistory(this.repository);

  @override
  Future<Either<Failure, DrinkHistoryEntity>> call(
      UpdateDrinkHistoryParams params) async {
    return Future.value(
        repository.updateDrinkHistory(params.key, params.drinkHistoryModel));
  }
}

class UpdateDrinkHistoryParams extends Equatable {
  final int key;
  final DrinkHistoryModel drinkHistoryModel;

  UpdateDrinkHistoryParams(
      {@required this.key, @required this.drinkHistoryModel});

  @override
  List<Object> get props => [key, drinkHistoryModel];
}
