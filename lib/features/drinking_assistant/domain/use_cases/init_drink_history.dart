import 'package:drinking_assistant/features/drinking_assistant/data/models/drink_history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/repositories/drink_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class InitDrinkHistory {
  DrinkRepository repository;

  InitDrinkHistory(this.repository);

  call(InitHistoryParams params) {
    repository.initDrinkHistory(params.drinkHistoryModel);
  }
}

class InitHistoryParams extends Equatable {
  final DrinkHistoryModel drinkHistoryModel;

  InitHistoryParams({@required this.drinkHistoryModel });

  @override
  List<Object> get props => [drinkHistoryModel];
}
