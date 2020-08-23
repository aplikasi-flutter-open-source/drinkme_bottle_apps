import 'dart:convert';

import 'package:drinking_assistant/core/utils/date_helper.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/history_model.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/drink_history_entity.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/entities/history_item_entity.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'drink_history_model.g.dart';

DrinkHistoryModel drinkHistoryModelFromJson(String str) =>
    DrinkHistoryModel.fromJson(json.decode(str));

String drinkHistoryModelToJson(DrinkHistoryModel data) =>
    json.encode(data.toJson());

@HiveType(typeId: 0)
class DrinkHistoryModel extends DrinkHistoryEntity {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final double percentage;
  @HiveField(2)
  final List<HistoryItemEntity> histories;

//   set percentage(double newPersentage) {
//    percentage = newPersentage;
//  }

  DrinkHistoryModel({
    @required this.date,
    @required this.percentage,
    @required this.histories,
  }) : super(
          date: date,
          percentage: percentage,
          histories: histories,
        );

  factory DrinkHistoryModel.fromJson(Map<String, dynamic> json) =>
      DrinkHistoryModel(
        date: json["date"],
        percentage: json["percentage"],
        histories: List<HistoryItemEntity>.from(
            json["histories"].map((x) => HistoryItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "percentage": percentage,
        "histories": histories ?? null,
      };

  factory DrinkHistoryModel.initToday() {
    print('initToday');

    return DrinkHistoryModel(
        date: DateTimeHelper.nowFormatddMMyyyy,
        //DateFormat('dd-MM-yyyy').format(DateTime.now()),
        percentage: 95.0,
        histories: [
          HistoryItemModel(
              id: 1,
              isComplete: false,
              hour: '0000-00-00 08:00:00',
              percentage: 66.66666667),
//                percentage: 83.33333333),
          HistoryItemModel(
              id: 2,
              isComplete: false,
              hour: '0000-00-00 09:00:00',
              percentage: 50.0),
//                percentage: 66.66666667),
          HistoryItemModel(
              id: 3,
              isComplete: false,
              hour: '0000-00-00 10:00:00',
              percentage: 33.33333333),
//                percentage: 50.0),
          HistoryItemModel(
              id: 4,
              isComplete: false,
              hour: '0000-00-00 11:00:00',
              percentage: 16.66666667),
//                percentage: 33.33333333),
          HistoryItemModel(
              id: 5,
              isComplete: false,
              hour: '0000-00-00 12:00:00',
              percentage: 83.33333333),
//                percentage: 16.66666667),
          HistoryItemModel(
              id: 6,
              isComplete: false,
              hour: '0000-00-00 14:00:00',
              percentage: 66.66666667),
//                percentage: 83.33333333),
          HistoryItemModel(
              id: 7,
              isComplete: false,
              hour: '0000-00-00 15:00:00',
              percentage: 50.0),
//                percentage: 66.66666667),
          HistoryItemModel(
              id: 8,
              isComplete: false,
              hour: '0000-00-00 16:00:00',
              percentage: 33.33333333),
//                percentage: 50.0),
          HistoryItemModel(
              id: 9,
              isComplete: false,
              hour: '0000-00-00 17:00:00',
              percentage: 16.66666667),
          //  percentage: 33.33333333),
          HistoryItemModel(
              id: 10,
              isComplete: false,
              hour: '0000-00-00 18:00:00',
              percentage: 0),
//                percentage: 16.66666667),
        ]);
  }
}
