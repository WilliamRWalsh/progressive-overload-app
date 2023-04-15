import 'package:hive_flutter/hive_flutter.dart';

class ExerciseSet {
  ExerciseSet({
    required this.guid,
    required this.weight,
    required this.reps,
    required this.isOverridden,
  });

  @HiveField(0)
  String guid;
  @HiveField(1)
  int reps;
  @HiveField(2)
  double weight;
  @HiveField(3)
  bool isOverridden;
}
