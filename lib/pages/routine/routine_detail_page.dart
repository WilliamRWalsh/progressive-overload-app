import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/models/routine.model.dart';
import 'package:progressive_overload_app/pages/exercise/session_page.dart';
import 'package:progressive_overload_app/routing/fade_route.dart';

class RoutineDetailPage extends ConsumerWidget {
  const RoutineDetailPage({Key? key, required this.routine}) : super(key: key);

  final Routine routine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(routine.name)),
      ),
      body: ListView.builder(
        itemCount: routine.exerciseTypes.length,
        itemBuilder: (context, index) {
          final type = routine.exerciseTypes[index];
          return Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    FadeRoute(
                      child: SessionPage(type: type),
                    ),
                  );
                },
                child: Text(type.name),
              ),
            ),
          );
        },
      ),
    );
  }
}
