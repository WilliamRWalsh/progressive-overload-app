import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/main.dart';
import 'package:progressive_overload_app/models/routine.model.dart';
import 'package:progressive_overload_app/pages/exercise/session_page.dart';
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
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Card(
                  color: Colors.black,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Icon(
                      Icons.check,
                      color: green,
                      size: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: SizedBox(
                        height: 60,
                        child: Center(
                            child: Text(
                          type.name,
                          style: Theme.of(context).textTheme.labelLarge,
                        ))),
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
