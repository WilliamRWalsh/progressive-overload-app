import 'package:hive_flutter/hive_flutter.dart';

part 'exercise_set.model.g.dart';

@HiveType(typeId: 3)
class ExerciseSet {
  ExerciseSet({
    this.overrideWeight,
    this.reps,
  });

  @HiveField(0)
  int? reps;
  @HiveField(1)
  double? overrideWeight;
}
