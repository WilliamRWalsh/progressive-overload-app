// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SetAdapter extends TypeAdapter<Set> {
  @override
  final int typeId = 2;

  @override
  Set read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Set(
      weight: fields[1] as double,
      reps: fields[0] as int,
      isOverridden: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Set obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.reps)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.isOverridden);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
