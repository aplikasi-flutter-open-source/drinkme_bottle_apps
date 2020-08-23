import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class HistoryItemEntity extends Equatable {
  HistoryItemEntity({
    @required this.id,
    @required this.isComplete,
    @required this.percentage,
    @required this.hour,
  });

  final int id;
  final bool isComplete;
  final String hour;
  final double percentage;

  @override
  List<Object> get props => [id, isComplete, hour, percentage];
}
