import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/exercise_type.model.dart';
import 'package:progressive_overload_app/models/routine.model.dart';

class ExerciseTypeHiveService {
  ExerciseTypeHiveService();

  static String boxName = 'exerciseTypeBox';
  final box = Hive.box<ExerciseType>(boxName);

  List<ExerciseType> getAll() => box.values.toList();

  Future<void> set(ExerciseType routine) async => await box.add(routine);
}

final providerOfExerciseTypeHiveService =
    Provider((ref) => ExerciseTypeHiveService());
