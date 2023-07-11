import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/routine.model.dart';

class RoutineHiveService {
  RoutineHiveService();

  static String boxName = 'routineBox';

  Future<List<Routine>> getAll() async {
    final box = await Hive.openBox<Routine>(boxName);
    return box.values.toList();
  }

  Future<void> set(Routine routine) async {
    final box = await Hive.openBox<Routine>(boxName);
    box.put(routine.guid, routine);
  }
}

final providerOfRoutineHiveService = Provider((ref) => RoutineHiveService());
