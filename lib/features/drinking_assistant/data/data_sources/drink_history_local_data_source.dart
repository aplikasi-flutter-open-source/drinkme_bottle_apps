import 'package:drinking_assistant/core/error/exception.dart';
import 'package:drinking_assistant/core/utils/const.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/drink_history_model.dart';
import 'package:hive/hive.dart';

abstract class DrinkHistoryLocalDataSource {
  List<DrinkHistoryModel> getDrinkHistory();

  void initDrinkHistory(DrinkHistoryModel drinkHistoryToInit);

  DrinkHistoryModel updateDrinkHistory(
      int key, DrinkHistoryModel drinkHistoryToUpdate);
}

class DrinkHistoryLocalDataSourceImpl implements DrinkHistoryLocalDataSource {
  final HiveInterface hive;

  DrinkHistoryLocalDataSourceImpl({this.hive});

  @override
  List<DrinkHistoryModel> getDrinkHistory() {
    final box = hive.box(DRINK_HISTORY_BOX);
    if (box.isEmpty) throw CacheException();
//    box.deleteAll([0]);
    return box.values.cast<DrinkHistoryModel>().toList();
  }

  @override
  void initDrinkHistory(DrinkHistoryModel historyToInit) {
    final box = hive.box(DRINK_HISTORY_BOX);
    box.add(historyToInit);
  }

  @override
  DrinkHistoryModel updateDrinkHistory(
      int key, DrinkHistoryModel drinkHistoryToUpdate) {
    final box = hive.box(DRINK_HISTORY_BOX);
    box.put(key, drinkHistoryToUpdate);
    return box.getAt(key);
  }
}
