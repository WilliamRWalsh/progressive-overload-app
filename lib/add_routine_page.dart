import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/shared/auto_complete_text_field.dart';

class AddRoutinePage extends ConsumerWidget {
  const AddRoutinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numOfExercises = ref.watch(_providerOfNumOfExercises);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add a Routine')),
      ),
      body: Form(
        child: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter a name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (val) =>
                          ref.read(_providerOfName.notifier).state = val,
                    ),
                    const SizedBox(height: 12),
                    for (int i = 0; i < numOfExercises; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: AutoCompleteTextField(
                          items: [],
                          onSubmitted: (val) {
                            final exerciseNames = Map<int, String>.from(
                                ref.read(_providerOfExerciseNames));
                            print('val: $val');

                            exerciseNames[i] = val;
                            ref.read(_providerOfExerciseNames.notifier).state =
                                exerciseNames;
                          },
                          decoration: InputDecoration(
                            labelText: 'Exercise #${i + 1}',
                            hintText: 'Enter Exercise Name',
                          ),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(_providerOfNumOfExercises.notifier).state =
                            numOfExercises + 1;
                      },
                      child: const Icon(
                        Icons.add,
                        size: 36,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        final form = Form.of(context);
                        if (!form.validate()) {
                          return;
                        }
                        form.save();

                        print(ref.read(_providerOfExerciseNames));

                        // add to hive
                        // pop
                      },
                      child: const Text('Add Routine')),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

final _providerOfName = AutoDisposeStateProvider<String?>((ref) => null);
final _providerOfNumOfExercises = AutoDisposeStateProvider<int>((ref) => 3);
final _providerOfExerciseNames =
    AutoDisposeStateProvider<Map<int, String>>((ref) => <int, String>{});
