import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/hive_services/routine_hive_service.dart';
import 'package:progressive_overload_app/main.dart';
import 'package:progressive_overload_app/models/exercise_type.model.dart';
import 'package:progressive_overload_app/models/routine.model.dart';
import 'package:progressive_overload_app/providers/exercise_type_state.dart';
import 'package:progressive_overload_app/providers/routine_state.dart';
import 'package:progressive_overload_app/shared/auto_complete_text_field.dart';
import 'package:uuid/uuid.dart';

class AddEditRoutinePage extends ConsumerStatefulWidget {
  const AddEditRoutinePage({super.key, this.routine});
  final Routine? routine;

  @override
  ConsumerState<AddEditRoutinePage> createState() => _AddEditRoutinePageState();
}

class _AddEditRoutinePageState extends ConsumerState<AddEditRoutinePage> {
  late StateController<Routine?> stateController;
  @override
  void initState() {
    super.initState();
    stateController = StateController(widget.routine);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.routine != null;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(isEdit ? 'Edit Routine' : 'Add a Routine')),
      ),
      body: ProviderScope(
        overrides: [_providerOfRoutine.overrideWithValue(stateController)],
        child: Consumer(builder: (context, ref, _) {
          final numOfExercises = ref.watch(_providerOfNumOfExercises);
          final exerciseTypes = ref.watch(providerOfExerciseTypes);
          final routineLen = widget.routine?.exerciseTypes.length ?? -1;
          return Form(
            child: Builder(builder: (context) {
              return exerciseTypes.when(
                  data: (exerciseTypes) => Padding(
                        padding: const EdgeInsets.all(12),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextFormField(
                                initialValue: widget.routine?.name,
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
                                onSaved: (val) => ref
                                    .read(_providerOfName.notifier)
                                    .state = val,
                              ),
                              const SizedBox(height: 12),
                              for (int i = 0; i < numOfExercises; i++)
                                Builder(builder: (context) {
                                  final length =
                                      widget.routine?.exerciseTypes.length;
                                  final hasValue =
                                      length != null && i < length - 1;
                                  final initalValue = hasValue
                                      ? widget.routine?.exerciseTypes[i].name
                                      : '';
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: AutoCompleteTextField(
                                      initialValue: initalValue,
                                      items: exerciseTypes
                                          .map((e) => e.name)
                                          .toList(),
                                      onSubmitted: (val) {
                                        if (val.isEmpty) {
                                          return;
                                        }

                                        final existingType =
                                            exerciseTypes.firstWhereOrNull(
                                          (e) => e.name == val,
                                        );

                                        final types = List<ExerciseType>.from(
                                          ref.read(
                                              _providerOfRoutineExerciseTypes),
                                        );

                                        types.add(
                                          existingType ??
                                              ExerciseType(
                                                guid: const Uuid().v4(),
                                                name: val,
                                              ),
                                        );

                                        ref
                                            .read(
                                                _providerOfRoutineExerciseTypes
                                                    .notifier)
                                            .state = types;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Exercise #${i + 1}',
                                        hintText: 'Enter Exercise Name',
                                      ),
                                    ),
                                  );
                                }),
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(_providerOfNumOfExercises.notifier)
                                      .state = numOfExercises + 1;
                                },
                                icon: Container(
                                  color: green,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 100),
                              SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      final form = Form.of(context);
                                      if (!form.validate()) {
                                        return;
                                      }

                                      form.save();

                                      final routineService = ref
                                          .read(providerOfRoutineHiveService);

                                      final name =
                                          ref.read(_providerOfName) ?? '';
                                      final types = ref.read(
                                          _providerOfRoutineExerciseTypes);

                                      await routineService.set(
                                        Routine(
                                          guid: const Uuid().v4(),
                                          name: name,
                                          exerciseTypes: types,
                                        ),
                                      );
                                      ref.refresh(providerOfRoutines);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Save')),
                              )
                            ],
                          ),
                        ),
                      ),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (error, stackTrace) =>
                      const Text('Oops a wild error'));
            }),
          );
        }),
      ),
    );
  }
}

final _providerOfName = AutoDisposeStateProvider<String?>((ref) {
  final routine = ref.watch(_providerOfRoutine);
  return routine?.name;
}, dependencies: [_providerOfRoutine]);

final _providerOfNumOfExercises = AutoDisposeStateProvider<int>((ref) {
  final routine = ref.watch(_providerOfRoutine);
  return routine != null ? routine.exerciseTypes.length : 3;
}, dependencies: [_providerOfRoutine]);

final _providerOfRoutineExerciseTypes =
    AutoDisposeStateProvider<List<ExerciseType>>((ref) {
  final routine = ref.watch(_providerOfRoutine);
  return routine != null ? routine.exerciseTypes : [];
}, dependencies: [_providerOfRoutine]);

final _providerOfRoutine = AutoDisposeStateProvider<Routine?>((ref) => null);
