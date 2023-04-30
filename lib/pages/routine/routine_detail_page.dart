import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/main.dart';
import 'package:progressive_overload_app/models/routine.model.dart';
import 'package:progressive_overload_app/models/session.model.dart';
import 'package:progressive_overload_app/pages/session/session_page.dart';
import 'package:progressive_overload_app/providers/exercise_state.dart';
import 'package:progressive_overload_app/routing/fade_route.dart';
import 'package:progressive_overload_app/routing/slide_in_route.dart';

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
          final status =
              ref.watch(_providerOfSessionStatus(type.guid)).asData?.value;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Card(
                  color: Colors.black,
                  child: Builder(builder: (context) {
                    if (status == SessionStatus.EMPTY) {
                      return const SizedBox(
                        height: 60,
                        width: 60,
                        child: Icon(
                          Icons.circle_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                      );
                    }

                    if (status == SessionStatus.COMPLETED) {
                      return const SizedBox(
                        height: 60,
                        width: 60,
                        child: Icon(
                          Icons.check,
                          color: green,
                          size: 40,
                        ),
                      );
                    }

                    if (status == SessionStatus.IN_PROGRESS) {
                      return const SizedBox(
                        height: 60,
                        width: 60,
                        child: Icon(
                          Icons.do_disturb_on_outlined,
                          color: Colors.orange,
                          size: 40,
                        ),
                      );
                    }

                    return const SizedBox(
                      height: 60,
                      width: 60,
                      child: Icon(
                        Icons.circle_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: Card(
                    child: SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          type.name,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    child: const Icon(Icons.forward),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        SlideInRoute(
                          child: SessionPage(type: type),
                        ),
                      );
                      ref.refresh(providerOfSessions);
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

final _providerOfSessionStatus =
    AutoDisposeFutureProvider.family<SessionStatus, String>((ref, guid) async {
  final allSessions = await ref.watch(providerOfSessions.future);
  final reversedSession =
      allSessions.where((e) => e.type.guid == guid).toList().reversed.toList();

  if (reversedSession.isEmpty ||
      DateTime.now().difference(reversedSession[0].date).inMinutes >= 120) {
    return SessionStatus.EMPTY;
  }

  if (reversedSession[0].sets?.any((s) => s?.reps == null) == true) {
    return SessionStatus.IN_PROGRESS;
  }

  return SessionStatus.COMPLETED;
});

enum SessionStatus {
  EMPTY,
  IN_PROGRESS,
  COMPLETED,
}
