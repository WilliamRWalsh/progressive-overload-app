import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/add_routine_page.dart';
import 'package:progressive_overload_app/providers/routine_state.dart';

import 'models/routine.model.dart';

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
              return ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddRoutinePage(),
                    ),
                  );
                },
                child: Text(routine.name),
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

// Padding(
//         padding: const EdgeInsets.all(12),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               for (Routine routine in routines)
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       // await Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => const AddRoutinePage(),
//                       //   ),
//                       // );
//                     },
//                     child: Text(routine.name),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
