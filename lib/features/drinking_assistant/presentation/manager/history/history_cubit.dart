import 'package:bloc/bloc.dart';
import 'package:drinking_assistant/core/usecases/usecase.dart';
import 'package:drinking_assistant/core/utils/date_helper.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/drink_history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/get_drink_history.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetDrinkHistory _getDrinkHistory;

  HistoryCubit({@required GetDrinkHistory getDrinkHist})
      : assert(getDrinkHist != null),
        _getDrinkHistory = getDrinkHist,
        super(HistoryInitial());

  void getDrinkHistory() async {
    final failureOrListDrinkHistory = await _getDrinkHistory(NoParams());
    failureOrListDrinkHistory.fold((failure) {
      emit(EmptyHistoryState());
    }, (listDrinkHistory) async {
      Map<DateTime, List> toShowInCalendar = {};

      print('DATAA length ${listDrinkHistory.length}');
      print('DATAA ${drinkHistoryModelToJson(listDrinkHistory.last)}');

      listDrinkHistory.forEach((drinkHistory) {
        toShowInCalendar[DateTimeHelper.dateTimeddMMyyyyFromString(drinkHistory.date)] =
            drinkHistory.histories.map((historyItem) => historyItem).toList();
      });

      //      listDrinkHistory.forEach((drinkHistory) {
//        toShowInCalendar[DateHelper.dateTimeFromFormat(drinkHistory.date)] =
//            drinkHistory.histories
//                .where((historyItem) => historyItem.isComplete)
//                .toList();
//      });

      print('toShowInCalendar $toShowInCalendar');

      emit(HistoryLoadedState(mapEventsHistoryDrink: toShowInCalendar));
    });
  }
}
