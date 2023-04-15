import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../hive_services/exercise_hive_service.dart';
import '../models/exercise.model.dart';

final providerOfExercises = AutoDisposeStateProvider<List<Exercise>>((ref) {
  final hive = ref.watch(providerOfExerciseHiveService);
  return hive.getAll();
});
