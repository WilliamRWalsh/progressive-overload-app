// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_type.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseTypeAdapter extends TypeAdapter<ExerciseType> {
  @override
  final int typeId = 1;

  @override
  ExerciseType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseType(
      guid: fields[0] as String,
      name: fields[1] as String,
      sets: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.guid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
