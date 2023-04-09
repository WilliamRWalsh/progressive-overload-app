import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/exercise_set.model.dart';
import 'package:progressive_overload_app/models/exercise_type.model.dart';

part 'exercise.model.g.dart';

@HiveType(typeId: 0)
class Exercise extends HiveObject {
  Exercise({
    required this.guid,
    required this.type,
    required this.date,
    this.sets,
  });

  @HiveField(0)
  String guid;
  @HiveField(1)
  ExerciseType type;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  List<ExerciseSet>? sets;
}
