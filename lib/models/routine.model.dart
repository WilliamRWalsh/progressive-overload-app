import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/exercise_type.model.dart';

part 'routine.model.g.dart';

@HiveType(typeId: 2)
class Routine {
  Routine({
    required this.guid,
    required this.name,
    required this.exerciseTypes,
  });

  @HiveField(0)
  String guid;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<ExerciseType> exerciseTypes;
}
