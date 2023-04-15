import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/models/routine.model.dart';
import 'package:progressive_overload_app/pages/exercise/exercise_page.dart';

class RoutineDetailPage extends ConsumerWidget {
  const RoutineDetailPage({Key? key, required this.routine}) : super(key: key);

  final Routine routine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(routine.name)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // todo use listview builder
            // take up width
            for (final type in routine.exerciseTypes)
              SizedBox(
                height: 60,
                child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          // todo pass in type guid
                          builder: (context) => const ExercisePage(),
                        ),
                      );
                    },
                    child: Text(type.name)),
              )
          ],
        ),
      ),
    );
  }
}
