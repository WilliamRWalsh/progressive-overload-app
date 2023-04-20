import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/session.model.dart';

class SessionHiveService {
  SessionHiveService();

  static String boxName = 'exerciseBox';

  Future<List<Session>> getAll() async {
    final box = await Hive.openBox<Session>(boxName);
    return box.values.toList();
  }

  Future<void> set(Session exercise) async {
    final box = await Hive.openBox<Session>(boxName);
    await box.add(exercise);
  }
}

final providerOfSessionHiveService = Provider((ref) => SessionHiveService());
