import 'dart:convert';

import 'package:drinking_assistant/features/drinking_assistant/domain/entities/bottle_entity.dart';
import 'package:meta/meta.dart';

class BottleModel extends BottleEntity {
  BottleModel({
    @required int idBottle,
    @required int bottleCode,
    @required String message,
    @required String status,
  }) : super(
            idBottle: idBottle,
            bottleCode: bottleCode,
            message: message,
            status: status);

  factory BottleModel.fromJson(Map<String, dynamic> json) => BottleModel(
        idBottle: json["idBottle"],
        bottleCode: json["bottleCode"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "idBottle": idBottle,
        "bottleCode": bottleCode,
        "message": message,
        "status": status,
      };
}

BottleModel bottleModelFromJson(String str) =>
    BottleModel.fromJson(json.decode(str));

String bottleModelToJson(BottleModel data) => json.encode(data.toJson());
