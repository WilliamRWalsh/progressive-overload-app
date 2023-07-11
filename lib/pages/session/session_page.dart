import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:progressive_overload_app/hive_services/session_hive_service.dart';
import 'package:progressive_overload_app/main.dart';
import 'package:progressive_overload_app/models/session.model.dart';
import 'package:progressive_overload_app/models/exercise_set.model.dart';
import 'package:progressive_overload_app/providers/exercise_state.dart';
import 'package:progressive_overload_app/shared/unsaved_changes_dialog.dart';
import 'package:progressive_overload_app/utils/number_utils.dart';
import 'package:progressive_overload_app/utils/timer.dart';
import 'package:uuid/uuid.dart';

import '../../models/exercise_type.model.dart';

class SessionPage extends ConsumerWidget {
  const SessionPage({Key? key, required this.type}) : super(key: key);
  final ExerciseType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incompleteSessionAsync =
        ref.watch(_providerOfIncompleteSession(type.guid));
    final _ = ref.watch(_providerOfSets);
    final __ = ref.watch(_providerOfWeight);

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog(
          context: context,
          builder: (context) {
            return const UnsavedChangesDialog();
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
            return SessionForm(
              incompleteSession: incompleteSession,
              type: type,
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

class SessionForm extends ConsumerStatefulWidget {
  const SessionForm({super.key, this.incompleteSession, required this.type});
  final Session? incompleteSession;
  final ExerciseType type;

  @override
  ConsumerState<SessionForm> createState() => _SessionFormState();
}

class _SessionFormState extends ConsumerState<SessionForm> {
  late StateController<Session> sessionStateController;

  @override
  void initState() {
    super.initState();
    sessionStateController = StateController(
      widget.incompleteSession ??
          Session(
            guid: const Uuid().v4(),
            type: widget.type,
            date: DateTime.now(),
            weight: 0,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(_providerOfTimer);

    final last3ExercisesAsync =
        ref.watch(_providerOfLast3CompletedSessions(widget.type.guid));
    return last3ExercisesAsync.when(
      data: (last3Exercises) {
        final weight = last3Exercises.firstOrNull?.weight;

        return ProviderScope(
          overrides: [
            _providerOfSession.overrideWithValue(sessionStateController)
          ],
          child: Consumer(builder: (context, ref, _) {
            final session = ref.watch(_providerOfSession);
            final last3StrIndex = {
              for (final e in last3Exercises)
                e.guid: ((e.sets
                                ?.map((s) => s?.reps)
                                .whereType<int>()
                                .reduce((value, element) => value + element) ??
                            0) *
                        e.weight /
                        42)
                    .floor(),
            };

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                child: Builder(builder: (context) {
                  return Column(
                    children: [
                      //todo: move this outside of SessionForm
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
                                      Stack(
                                        alignment: Alignment.topRight,
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
                                    ],
                                  ),
                                  const VerticalDivider(
                                    width: 20,
                                    thickness: 1,
                                    color: appBarColor,
                                  ),
                                  for (ExerciseSet? s in session.sets ?? [])
                                    Builder(builder: (context) {
                                      final overrideWieght = s?.overrideWeight;
                                      if (overrideWieght == null) {
                                        return SizedBox(
                                          width: 65,
                                          child: TextFormField(
                                            enabled: false,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            initialValue: s?.reps?.toString(),
                                          ),
                                        );
                                      }
                                      return Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          SizedBox(
                                            width: 65,
                                            child: TextFormField(
                                              enabled: false,
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              initialValue: s?.reps?.toString(),
                                            ),
                                          ),
                                          if (overrideWieght != session.weight)
                                            Icon(
                                              (overrideWieght > session.weight)
                                                  ? Icons.arrow_drop_up_sharp
                                                  : Icons.arrow_drop_down_sharp,
                                              size: 28,
                                              color: (overrideWieght >
                                                      session.weight)
                                                  ? cardColor
                                                  : secondaryActionColor,
                                            )
                                        ],
                                      );
                                    }),
                                  SizedBox(width: 5),
                                  CircleAvatar(
                                    backgroundColor: cardColor,
                                    child: Center(
                                      child: Text(
                                        last3StrIndex[session.guid].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ),
                                  )
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
                                        textInputAction: TextInputAction.next,
                                        autofocus:
                                            (widget.incompleteSession?.weight ??
                                                    weight) ==
                                                null,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        initialValue: getFormatedDecimal(
                                            widget.incompleteSession?.weight ??
                                                weight),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4)
                                        ],
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter Weight';
                                          }
                                          return null;
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
                                    const SizedBox(height: 16)
                                  ],
                                ),
                                const VerticalDivider(
                                  width: 20,
                                  thickness: 2,
                                  color: appBarColor,
                                ),
                                // pass value from `incompleteSession`
                                for (var i = 0; i < widget.type.sets; i++)
                                  RepField(set: session.sets?[i]),
                                const SizedBox(width: 5),
                                const CircleAvatar(
                                  backgroundColor: backgroundColor,
                                  child: null,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryActionColor,
                                ),
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

                                  final newSession =
                                      ref.read(_providerOfSession);
                                  newSession.sets = sets;
                                  newSession.weight = weight ?? 0;
                                  ref.read(_providerOfSession.notifier).state =
                                      newSession;

                                  await hiveSession.set(newSession);
                                  ref.refresh(_providerOfSets);

                                  // TODO: showToast
                                },
                                child: Text(
                                  'Save',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: backgroundColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
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

                                  final newSession =
                                      ref.read(_providerOfSession);
                                  newSession.sets = sets;
                                  newSession.weight = weight ?? 0;
                                  ref.read(_providerOfSession.notifier).state =
                                      newSession;

                                  await hiveSession.set(newSession);
                                  ref.refresh(providerOfSessions);

                                  // showToast('Changes Saved!');

                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Continue',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(color: backgroundColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }),
              ),
            );
          }),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Text('Oops something went wrong: $error'),
    );
  }
}

class RepField extends ConsumerStatefulWidget {
  const RepField({Key? key, this.set}) : super(key: key);

  @override
  ConsumerState<RepField> createState() => _RepFieldState();

  final ExerciseSet? set;
}

class _RepFieldState extends ConsumerState<RepField> {
  late ValueKey<ExerciseSet> fieldKey;

  @override
  void initState() {
    super.initState();

    fieldKey = ValueKey<ExerciseSet>(
      ExerciseSet(
        reps: widget.set?.reps,
        overrideWeight: widget.set?.overrideWeight,
      ),
    );
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return FormField<ExerciseSet>(
      key: fieldKey,
      initialValue: fieldKey.value,
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
              textInputAction: TextInputAction.next,
              initialValue: widget.set?.reps?.toString(),
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
                if (value != null && value.length > 1) {
                  TextInputAction.next;
                }
              },
              validator: (String? value) => null,
            ),
          ),
          if (isExpanded) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: 65,
              child: TextFormField(
                initialValue: widget.set?.overrideWeight?.toString(),
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

  final sorted = exercises.where((e) => e.type.guid == guid).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
  final three = sorted
      .take(4)
      .where((e) =>
          DateTime.now().difference(e.date).inMinutes > 120 ||
          e.sets?.every((s) => s?.reps != null) == true)
      .take(3)
      .toList()
      .reversed
      .toList();

  return three;
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

final _providerOfSession = AutoDisposeStateProvider<Session>(
    (ref) => throw '_providerOfSession needs to be scoped.');
