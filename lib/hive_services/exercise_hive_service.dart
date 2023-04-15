import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/exercise.model.dart';
import 'package:progressive_overload_app/models/routine.model.dart';

class ExerciseService {
  ExerciseService();

  static String boxName = 'exerciseBox';
  final box = Hive.box<Exercise>(boxName);

  List<Exercise> getAll() => box.values.toList();

  Future<void> set(Exercise routine) async => await box.add(routine);
}

final providerOfExerciseHiveService = Provider((ref) => ExerciseService());
