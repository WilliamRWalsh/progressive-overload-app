import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/hive_services/routine_hive_service.dart';
import 'package:progressive_overload_app/models/routine.model.dart';

final providerOfRoutines = AutoDisposeStateProvider<List<Routine>>((ref) {
  final routineHive = ref.watch(providerOfRoutineHiveService);
  return routineHive.getAll();
});
