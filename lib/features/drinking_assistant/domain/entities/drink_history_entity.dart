import 'package:drinking_assistant/features/drinking_assistant/domain/entities/history_item_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DrinkHistoryEntity extends Equatable {
  DrinkHistoryEntity({
    @required this.date,
    @required this.percentage,
    @required this.histories,
  });

  final String date;

  final double percentage;

  final List<HistoryItemEntity> histories;

  @override
  List<Object> get props => [date, percentage, histories];
}
