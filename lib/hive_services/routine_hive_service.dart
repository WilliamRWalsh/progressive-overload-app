import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/routine.model.dart';

class RoutineHiveService {
  RoutineHiveService();

  static String boxName = 'routineBox';
  final box = Hive.box<Routine>(boxName);

  List<Routine> getAll() => box.values.toList();

  Future<void> set(Routine routine) async => await box.add(routine);
}

final providerOfRoutineHiveService = Provider((ref) => RoutineHiveService());
