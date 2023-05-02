import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progressive_overload_app/models/session.model.dart';

class SessionHiveService {
  SessionHiveService();

  static String boxName = 'sessionBox';

  Future<List<Session>> getAll() async {
    final box = await Hive.openBox<Session>(boxName);
    return box.values.toList();
  }

  Future<void> set(Session session) async {
    final box = await Hive.openBox<Session>(boxName);
    await box.put(session.guid, session);
  }
}

final providerOfSessionHiveService = Provider((ref) => SessionHiveService());
