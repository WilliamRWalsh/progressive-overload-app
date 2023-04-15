import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/hive_services/exercise_type_hive_service.dart';
import 'package:progressive_overload_app/models/exercise_type.model.dart';

final providerOfExerciseTypes =
    AutoDisposeFutureProvider<List<ExerciseType>>((ref) {
  final hive = ref.watch(providerOfExerciseTypeHiveService);
  return hive.getAll();
});
