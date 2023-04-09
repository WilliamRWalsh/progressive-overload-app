import 'package:hive_flutter/hive_flutter.dart';

part 'exercise_type.model.g.dart';

@HiveType(typeId: 1)
class ExerciseType {
  ExerciseType({
    required this.guid,
    required this.name,
  });

  @HiveField(0)
  String guid;
  @HiveField(1)
  String name;
}
