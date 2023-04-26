import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/hive_services/session_hive_service.dart';
import 'package:progressive_overload_app/models/session.model.dart';
import 'package:progressive_overload_app/models/exercise_set.model.dart';
import 'package:progressive_overload_app/providers/exercise_state.dart';
import 'package:progressive_overload_app/utils/number_utils.dart';
import 'package:uuid/uuid.dart';

import '../../models/exercise_type.model.dart';

class SessionPage extends ConsumerWidget {
  const SessionPage({Key? key, required this.type}) : super(key: key);
  final ExerciseType type;

// todo: hook up timer

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final last3ExercisesAsync = ref.watch(_providerOfLast3Sessions(type.guid));
    final _ = ref.watch(_providerOfSets);
    final __ = ref.watch(_providerOfWeight);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(type.name)),
      ),
      body: last3ExercisesAsync.when(
        data: (last3Exercises) {
          final weight = last3Exercises.firstOrNull?.weight ?? 0;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              child: Builder(builder: (context) {
                return Column(
                  children: [
                    Text(
                      '30 secs',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        for (final session in last3Exercises)
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 65,
                                      child: TextFormField(
                                        enabled: false,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        initialValue:
                                            getFormatedDecimal(session.weight),
                                      ),
                                    ),
                                  ],
                                ),
                                const VerticalDivider(
                                  width: 20,
                                  thickness: 1,
                                  color: Colors.purple,
                                ),
                                for (final set in session.sets ?? [])
                                  SizedBox(
                                    width: 65,
                                    child: TextFormField(
                                      enabled: false,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      initialValue: set?.reps?.toString(),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 65,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      initialValue: getFormatedDecimal(weight),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4)
                                      ],
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Weight';
                                        }
                                      },
                                      onSaved: (val) {
                                        if (val == null) {
                                          return;
                                        }

                                        ref
                                            .read(_providerOfWeight.notifier)
                                            .state = double.parse(val);
                                      },
                                    ),
                                  ),
                                  // Balance the down arrow under rep boxes
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              ),
                              const VerticalDivider(
                                width: 20,
                                thickness: 2,
                                color: Colors.purple,
                              ),
                              const RepField(),
                              const RepField(),
                              const RepField(),
                              const RepField(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
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

                          final hiveSession =
                              ref.read(providerOfSessionHiveService);
                          final sets = ref.read(_providerOfSets);
                          final weight = ref.read(_providerOfWeight);
                          hiveSession.set(
                            Session(
                              guid: const Uuid().v4(),
                              date: DateTime.now(),
                              type: type,
                              sets: sets,
                              weight: weight ?? 0,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Done',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Text('Oops something went wrong: $error'),
      ),
    );
  }
}

class RepField extends ConsumerStatefulWidget {
  const RepField({Key? key}) : super(key: key);

  @override
  ConsumerState<RepField> createState() => _RepFieldState();
}

class _RepFieldState extends ConsumerState<RepField> {
  bool isExpanded = false;
  final fieldKey = ValueKey<ExerciseSet>(ExerciseSet());

  @override
  Widget build(BuildContext context) {
    return FormField<ExerciseSet>(
      key: fieldKey,
      onSaved: (val) {
        final sets = List<ExerciseSet?>.from(
          ref.read(_providerOfSets),
        );

        sets.add(val);
        ref.read(_providerOfSets.notifier).state = sets;
      },
      builder: (state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 65,
            child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2)
              ],
              decoration: const InputDecoration(hintText: '~'),
              onChanged: (String? value) {
                fieldKey.value.reps =
                    (value == null || value.isEmpty) ? null : int.parse(value);
                state.didChange(fieldKey.value);
              },
              validator: (String? value) => null,
            ),
          ),
          if (isExpanded) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: 65,
              child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2)
                ],
                decoration: const InputDecoration(hintText: 'lbs.'),
                onChanged: (String? value) {
                  fieldKey.value.overrideWeight =
                      (value == null || value.isEmpty)
                          ? null
                          : double.parse(value);
                  state.didChange(fieldKey.value);
                },
                validator: (String? value) => null,
              ),
            ),
          ],
          GestureDetector(
            child: Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up_outlined
                  : Icons.keyboard_arrow_down_outlined,
              color: Colors.orange,
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          )
        ],
      ),
    );
  }
}

final _providerOfLast3Sessions =
    AutoDisposeFutureProvider.family<List<Session>, String>((ref, guid) async {
  final exercises = await ref.watch(providerOfSessions.future);
  return exercises
      .where((e) => e.type.guid == guid)
      .toList()
      .reversed
      .take(3)
      .toList();
});

final _providerOfSets =
    AutoDisposeStateProvider<List<ExerciseSet?>>((ref) => []);

final _providerOfWeight = AutoDisposeStateProvider<double?>((ref) => null);
