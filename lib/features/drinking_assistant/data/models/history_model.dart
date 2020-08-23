import 'package:drinking_assistant/features/drinking_assistant/domain/entities/history_item_entity.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'history_model.g.dart';

@HiveType(typeId: 1)
class HistoryItemModel extends HistoryItemEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final bool isComplete;
  @HiveField(2)
  final String hour;
  @HiveField(3)
  final double percentage;

  HistoryItemModel({
    @required this.id,
    @required this.isComplete,
    @required this.hour,
    @required this.percentage,
  }) : super(
            id: id, isComplete: isComplete, hour: hour, percentage: percentage);

  factory HistoryItemModel.fromJson(Map<String, dynamic> json) => HistoryItemModel(
      id: json["id"],
      isComplete: json["isComplete"],
      hour: json["hour"],
      percentage: json["percentage"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "isComplete": isComplete,
        "hour": hour,
        "percentage": percentage,
      };
}
