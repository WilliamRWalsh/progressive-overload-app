import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/hive_services/routine_hive_service.dart';
import 'package:progressive_overload_app/models/routine.model.dart';

final providerOfRoutines =
    AutoDisposeFutureProvider<List<Routine>>((ref) async {
  final routineHive = ref.watch(providerOfRoutineHiveService);
  return await routineHive.getAll();
});
