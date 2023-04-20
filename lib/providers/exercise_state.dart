import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../hive_services/session_hive_service.dart';
import '../models/session.model.dart';

final providerOfSessions = AutoDisposeFutureProvider<List<Session>>((ref) {
  final hive = ref.watch(providerOfSessionHiveService);
  return hive.getAll();
});
