import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/pages/routine/add_routine_page.dart';
import 'package:progressive_overload_app/pages/routine/routine_detail_page.dart';
import 'package:progressive_overload_app/providers/routine_state.dart';

class RoutineListPage extends ConsumerWidget {
  const RoutineListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routines = ref.watch(providerOfRoutines);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Pick Your Routine')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddRoutinePage()),
        ),
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      body: routines.when(
        data: (routines) {
          return ListView.builder(
            itemCount: routines.length,
            itemBuilder: (context, index) {
              final routine = routines[index];
              return Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RoutineDetailPage(routine: routine),
                        ),
                      );
                    },
                    child: Text(routine.name),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(
          child: Text('An error occurred'),
        ),
      ),
    );
  }
}
