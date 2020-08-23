// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrinkHistoryModelAdapter extends TypeAdapter<DrinkHistoryModel> {
  @override
  final int typeId = 0;

  @override
  DrinkHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DrinkHistoryModel(
      date: fields[0] as String,
      percentage: fields[1] as double,
      histories: (fields[2] as List)?.cast<HistoryItemEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, DrinkHistoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.percentage)
      ..writeByte(2)
      ..write(obj.histories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrinkHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
