import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/hive_services/exercise_type_hive_service.dart';
import 'package:progressive_overload_app/hive_services/routine_hive_service.dart';

import '../hive_services/exercise_hive_service.dart';
import '../models/exercise.model.dart';

final providerOfExercises = AutoDisposeStateProvider<List<Exercise>>((ref) {
  final hive = ref.watch(providerOfExerciseHiveService);
  return hive.getAll();
});
