import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class BottleEntity extends Equatable {
  final int idBottle;
  final int bottleCode;
  final String status;
  final String message;

  BottleEntity(
      {@required this.idBottle,
      @required this.bottleCode,
      @required this.message,
      @required this.status});

  @override
  List<Object> get props => [idBottle, bottleCode, message, status];
}
