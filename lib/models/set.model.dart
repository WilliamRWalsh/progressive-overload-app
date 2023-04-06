import 'package:hive_flutter/hive_flutter.dart';

part 'set.model.g.dart';

@HiveType(typeId: 2)
class Set {
  Set({required this.weight, required this.reps, required this.isOverridden});

  @HiveField(0)
  int reps;
  @HiveField(1)
  double weight;
  @HiveField(2)
  bool isOverridden;
}
