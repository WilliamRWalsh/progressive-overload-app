import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExercisePage extends ConsumerWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Routine Name')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Bench Press')),
            ElevatedButton(onPressed: () {}, child: const Text('Bench Press')),
            ElevatedButton(onPressed: () {}, child: const Text('Bench Press')),
            ElevatedButton(onPressed: () {}, child: const Text('Bench Press'))
          ],
        ),
      ),
    );
  }
}
