import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/exercise_type.model.dart';

class ExerciseTypeHiveService {
  ExerciseTypeHiveService();

  static String boxName = 'exerciseTypeBox';

  Future<List<ExerciseType>> getAll() async {
    final box = await Hive.openBox<ExerciseType>(boxName);
    return box.values.toList();
  }

  Future<void> set(ExerciseType routine) async {
    final box = await Hive.openBox<ExerciseType>(boxName);
    await box.add(routine);
  }
}

final providerOfExerciseTypeHiveService =
    Provider((ref) => ExerciseTypeHiveService());
