import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/hive_services/session_hive_service.dart';
import 'package:progressive_overload_app/main.dart';
import 'package:progressive_overload_app/models/session.model.dart';
import 'package:progressive_overload_app/models/exercise_set.model.dart';
import 'package:progressive_overload_app/providers/exercise_state.dart';
import 'package:progressive_overload_app/shared/dirty_flag_form.dart';
import 'package:progressive_overload_app/utils/number_utils.dart';
import 'package:progressive_overload_app/utils/timer.dart';
import 'package:uuid/uuid.dart';

import '../../models/exercise_type.model.dart';

class SessionPage extends ConsumerWidget {
  const SessionPage({Key? key, required this.type}) : super(key: key);
  final ExerciseType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final last3ExercisesAsync =
        ref.watch(_providerOfLast3CompletedSessions(type.guid));
    final incompleteSessionAsync =
        ref.watch(_providerOfIncompleteSession(type.guid));
    final _ = ref.watch(_providerOfSets);
    final __ = ref.watch(_providerOfWeight);
    final timer = ref.watch(_providerOfTimer);
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Are you sure?',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Unsaved changes will be lost.',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryActionColor),
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Icon(
                              Icons.check_rounded,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Icon(
                              Icons.clear_rounded,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(type.name),
        ),
        body: incompleteSessionAsync.when(
          data: (incompleteSession) {
            return last3ExercisesAsync.when(
              data: (last3Exercises) {
                final weight = last3Exercises.firstOrNull?.weight ?? 0;

                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    child: Builder(builder: (context) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${timer.currentTime}',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const Icon(Icons.timer_outlined, size: 40),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Column(
                            children: [
                              for (final session in last3Exercises)
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 65,
                                            child: TextFormField(
                                              enabled: false,
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              initialValue: getFormatedDecimal(
                                                  session.weight),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const VerticalDivider(
                                        width: 20,
                                        thickness: 1,
                                        color: appBarColor,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 65,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            initialValue: getFormatedDecimal(
                                                incompleteSession?.weight ??
                                                    weight),
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  4)
                                            ],
                                            validator: (String? value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Enter Weight';
                                              }
                                              return null;
                                            },
                                            onSaved: (val) {
                                              if (val == null) {
                                                return;
                                              }

                                              ref
                                                  .read(_providerOfWeight
                                                      .notifier)
                                                  .state = double.parse(val);
                                            },
                                          ),
                                        ),
                                        // Balance the down arrow under rep boxes
                                        const SizedBox(height: 16)
                                      ],
                                    ),
                                    const VerticalDivider(
                                      width: 20,
                                      thickness: 2,
                                      color: appBarColor,
                                    ),
                                    // pass value from `incompleteSession`
                                    for (var i = 0; i < type.sets; i++)
                                      RepField(
                                          initialValue: incompleteSession
                                              ?.sets?[i]?.reps),
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
                              onPressed: () async {
                                final form = Form.of(context);
                                if (!form.validate()) {
                                  return;
                                }
                                form.save();

                                final hiveSession =
                                    ref.read(providerOfSessionHiveService);
                                final sets = ref.read(_providerOfSets);
                                final weight = ref.read(_providerOfWeight);
                                await hiveSession.set(
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
                                'Save & Continue',
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
              error: (error, stackTrace) =>
                  Text('Oops something went wrong: $error'),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => const Text('Oops a wild error'),
        ),
      ),
    );
  }
}

class RepField extends ConsumerStatefulWidget {
  const RepField({Key? key, this.initialValue}) : super(key: key);

  @override
  ConsumerState<RepField> createState() => _RepFieldState();

  final int? initialValue;
}

class _RepFieldState extends ConsumerState<RepField> {
  late ValueKey<ExerciseSet> fieldKey;

  @override
  void initState() {
    fieldKey = ValueKey<ExerciseSet>(ExerciseSet(reps: widget.initialValue));
    super.initState();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return FormField<ExerciseSet>(
      key: fieldKey,
      initialValue: ExerciseSet(reps: widget.initialValue),
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
              initialValue: widget.initialValue?.toString(),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2)
              ],
              decoration: const InputDecoration(hintText: '~'),
              onTap: () => ref.refresh(_providerOfTimer),
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
              color: secondaryActionColor,
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

final _providerOfLast3CompletedSessions =
    AutoDisposeFutureProvider.family<List<Session>, String>((ref, guid) async {
  final exercises = await ref.watch(providerOfSessions.future);

  return exercises
      .where((e) => e.type.guid == guid)
      .toList()
      .reversed
      .take(4)
      .where((e) =>
          DateTime.now().difference(e.date).inMinutes > 120 ||
          e.sets?.every((s) => s?.reps != null) == true)
      .take(3)
      .toList()
      .reversed
      .toList();
});

final _providerOfIncompleteSession =
    AutoDisposeFutureProvider.family<Session?, String>((ref, guid) async {
  final exercises = await ref.watch(providerOfSessions.future);

  final last = exercises.where((e) => e.type.guid == guid).lastOrNull;
  if (last != null &&
      DateTime.now().difference(last.date).inMinutes <= 120 &&
      last.sets?.any((e) => e?.reps == null) == true) {
    return last;
  }

  return null;
});

final _providerOfSets =
    AutoDisposeStateProvider<List<ExerciseSet?>>((ref) => []);

final _providerOfWeight = AutoDisposeStateProvider<double?>((ref) => null);

final _providerOfTimer = ChangeNotifierProvider.autoDispose<ClockController>(
    (ref) => ClockController());
