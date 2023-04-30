import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/main.dart';
import 'package:progressive_overload_app/pages/routine/add_routine_page.dart';
import 'package:progressive_overload_app/pages/routine/routine_detail_page.dart';
import 'package:progressive_overload_app/providers/routine_state.dart';
import 'package:progressive_overload_app/routing/fade_route.dart';
import 'package:progressive_overload_app/routing/slide_in_route.dart';

class RoutineListPage extends ConsumerWidget {
  const RoutineListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routines = ref.watch(providerOfRoutines);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pick Your Routine'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          FadeRoute(child: const AddEditRoutinePage()),
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
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        child: Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            FadeRoute(
                              child: AddEditRoutinePage(routine: routine),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: SizedBox(
                            height: 60,
                            child: Center(
                                child: Text(
                              routine.name,
                              style: Theme.of(context).textTheme.labelLarge,
                            ))),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        child: Icon(Icons.forward),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            SlideInRoute(
                              child: RoutineDetailPage(routine: routine),
                            ),
                          );
                        },
                      ),
                    )
                  ],
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
