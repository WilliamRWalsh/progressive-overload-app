import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/exercise_type.model.dart';

part 'exercise.model.g.dart';

@HiveType(typeId: 0)
class Exercise extends HiveObject {
  Exercise({required this.type, required this.date, this.sets});

  @HiveField(0)
  ExerciseType type;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  List<Set>? sets;
}
