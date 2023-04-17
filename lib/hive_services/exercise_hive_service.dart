import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/exercise.model.dart';

class ExerciseHiveService {
  ExerciseHiveService();

  static String boxName = 'exerciseBox';

  Future<List<Exercise>> getAll() async {
    final box = await Hive.openBox<Exercise>(boxName);
    return box.values.toList();
  }

  Future<void> set(Exercise routine) async {
    final box = await Hive.openBox<Exercise>(boxName);
    await box.add(routine);
  }
}

final providerOfExerciseHiveService = Provider((ref) => ExerciseHiveService());
