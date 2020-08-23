import 'package:bloc/bloc.dart';
import 'package:drinking_assistant/core/error/failures.dart';
import 'package:drinking_assistant/core/usecases/usecase.dart';
import 'package:drinking_assistant/core/utils/date_helper.dart';
import 'package:drinking_assistant/core/utils/input_converter.dart';
import 'package:drinking_assistant/core/utils/mapping.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/drink_history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/drink_history_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/history_item_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/authenticate_bottle.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/get_drink_history.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/init_drink_history.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/schedule_local_notif_alarm.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/update_drink_history.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'drink_state.dart';

class DrinkCubit extends Cubit<DrinkState> {
  final UpdateDrinkHistory _updateDrink;
  final GetDrinkHistory _getDrink;
  final InitDrinkHistory _initDrink;
  final ScheduleAlarm _scheduleAlarm;
  final AuthenticateBottle _authenticateBottle;
  final InputConverter _inputConverter;

  DrinkCubit({
    @required UpdateDrinkHistory updateDrink,
    @required GetDrinkHistory getDrink,
    @required InitDrinkHistory initDrink,
    @required ScheduleAlarm scheduleAlarm,
    @required AuthenticateBottle authenticateBottle,
    @required InputConverter inputConverter,
  })  : assert(updateDrink != null),
        assert(getDrink != null),
        assert(initDrink != null),
        assert(scheduleAlarm != null),
        assert(authenticateBottle != null),
        _updateDrink = updateDrink,
        _getDrink = getDrink,
        _initDrink = initDrink,
        _scheduleAlarm = scheduleAlarm,
        _authenticateBottle = authenticateBottle,
        _inputConverter = inputConverter,
        super(DrinkInitial());

  void authenticateBottle(String codeBottle) async {
    emit(DrinkLoadingState());
    _inputConverter.stringToUnsignedInteger(codeBottle).fold(
      (failure) => _emitDrinkFailure(failure),
      (codeBottleInt) async {
        final failureOrBottle =
            await _authenticateBottle(BottleCodeParams(codeBottleInt));
        failureOrBottle.fold(
          (failure) => _emitDrinkFailure(failure),
          (bottleEntity) {
            print('BERHASIL');
            initDrinkHistory(bottleEntity.message);
          },
        );
      },
    );
  }

  void initDrinkHistory(String bottleMessage) async {
    final failureOrDrinkHistory = await _getDrink(NoParams());
    failureOrDrinkHistory.fold(
      (failure) {
        //if first install
        print('_initDrink 1');
        final DrinkHistoryEntity drinkHistoryInit =
            DrinkHistoryModel.initToday();

        _initDrink(InitHistoryParams(drinkHistoryModel: drinkHistoryInit));
        drinkHistoryInit.histories.forEach((historyItem) {
          _scheduleAlarm(
              historyItem.id, DateTimeHelper.dateTimeFromString(historyItem.hour));
        });
      },
      (listDrinkHistory) {
        final String todayFormat = DateTimeHelper.nowFormatddMMyyyy;
        final DrinkHistoryEntity lastDrinkHistory = listDrinkHistory.last;
        if (!(lastDrinkHistory.date == todayFormat)) {
          final DrinkHistoryEntity drinkHistoryInit =
              DrinkHistoryModel.initToday();

          print('_initDrink 2');
          _initDrink(InitHistoryParams(drinkHistoryModel: drinkHistoryInit));
          drinkHistoryInit.histories.forEach((historyItem) {
            _scheduleAlarm(historyItem.id,
                DateTimeHelper.dateTimeFromString(historyItem.hour));
          });
        }
        print('DATAA ${listDrinkHistory.length}');
        print('DATAA ${drinkHistoryModelToJson(listDrinkHistory.last)}');
      },
    );
    emit(DrinkHistoryLoadedState(
        data: DrinkHistoryModel.initToday(), message: bottleMessage));
  }

  void getDrinkHistoryToday() async {
    final failureOrListDrinkHistory = await _getDrink(NoParams());
    failureOrListDrinkHistory.fold(
      (failure) {
        emit(EmptyDrinkState());
      },
      (listDrinkHistory) async {
        final DrinkHistoryEntity lastDrinkHistory = listDrinkHistory.last;
        final String todayFormat = DateTimeHelper.nowFormatddMMyyyy;
        if (!(lastDrinkHistory.date == todayFormat)) {
          emit(EmptyDrinkState());
        } else {
          /*  COBA
//          final int halfOfDayPointReminder = 5;
//          final int notYet = 0;
//
//          final List<HistoryItemEntity> listHistoryItemToShow = [];
//          final List<int> status = [];
//          final List<HistoryItemEntity> listHistoryItem =
//              lastDrinkHistory.histories;
//          int isCompleteTotal = notYet;
//          listHistoryItem.forEach((element) {
//            if (element.isComplete) isCompleteTotal += 1;
//          });
//
//          String limitHour =
//              isCompleteTotal == 4 ? '18:00:00.000000' : '12:30:01.000000';
//          final limitTimeHalfOfDay = DateHelper.dateTimeFromString(
//              '${DateHelper.nowyyyyMMdd} $limitHour');
//
//          status.clear();
//          listHistoryItem.forEach((historyItem) {
//            final double historyItemHourDouble =
//                DateHelper.toDoubleFromDateString(historyItem.hour);
//            final double dateTimeNowDouble =
//                DateHelper.toDoubleFromDateTime(DateHelper.now);
//
//            if (DateHelper.now.isBefore(limitTimeHalfOfDay)) {
//              if (historyItem.id <= halfOfDayPointReminder) {
//                listHistoryItemToShow.add(historyItem);
//                if (historyItem.isComplete) {
//                  status.add(DONE);
//                } else {
//                  if (historyItemHourDouble <= dateTimeNowDouble) {
//                    status.add(WAIT);
//                  } else {
//                    if (historyItemHourDouble - dateTimeNowDouble <= 1) {
//                      status.add(WAIT);
//                    } else {
//                      status.add(UPCOMING);
//                    }
//                  }
//                }
//              }
//            } else {
//              if (historyItem.id > halfOfDayPointReminder) {
//                listHistoryItemToShow.add(historyItem);
//                if (historyItem.isComplete) {
//                  status.add(DONE);
//                } else {
//                  if (historyItemHourDouble <= dateTimeNowDouble) {
//                    status.add(WAIT);
//                  } else {
//                    if (historyItemHourDouble - dateTimeNowDouble <= 1) {
//                      status.add(WAIT);
//                    } else {
//                      status.add(UPCOMING);
//                    }
//                  }
//                }
//              }
//            }
//          });
           COBA */
//          await Future.delayed(Duration(seconds: 2));

          emit(DrinkHistoryLoadedState(
              data: lastDrinkHistory, message: 'Hallo selamat datang'));
        }
      },
    );
  }

  void updateDrinkHistory(HistoryItemEntity historyItem) async {
    final failureOrListDrinkHistory = await _getDrink(NoParams());
    failureOrListDrinkHistory.fold(
      (failure) {
        emit(EmptyDrinkState());
      },
      (listDrinkHistory) async {
        int key = listDrinkHistory.length - 1;
        HistoryItemEntity historyItemEntity = HistoryItemModel(
            percentage: historyItem.percentage,
            hour: historyItem.hour,
            isComplete: historyItem.isComplete,
            id: historyItem.id);
        DrinkHistoryEntity drinkHistoryToday = DrinkHistoryModel(
            date: listDrinkHistory.last.date,
            percentage: historyItemEntity.percentage,
            histories: listDrinkHistory.last.histories);

        drinkHistoryToday.histories.asMap().forEach((index, value) {
          if (value.id == historyItem.id) {
            drinkHistoryToday.histories[index] = historyItemEntity;
          }
        });

        final failureOrDrinkHistory = await _updateDrink(
            UpdateDrinkHistoryParams(
                key: key, drinkHistoryModel: drinkHistoryToday));
        failureOrDrinkHistory.fold(
          (failure) {
            print(failure);
          },
          (drinkHistoryEntity) {
            emit(DrinkHistoryLoadedState(
                data: drinkHistoryEntity,
                message: 'Bagus lanjutkan terus ya...'));
          },
        );
      },
    );
  }

  _emitDrinkFailure(Failure failure) {
    emit(DrinkFailureState(message: Mapping.failureToMessage(failure)));
  }
}
