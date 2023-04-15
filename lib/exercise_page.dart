import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExercisePage extends ConsumerWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Bench Press')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          child: Column(
            children: [
              Text(
                '30 secs',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              Column(
                children: [
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
                                initialValue: '90',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '14',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '13',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '13',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '12',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                initialValue: '100',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '9',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '9',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '8',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '7',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                initialValue: '100',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                            ),
                          ],
                        ),
                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '10',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '9',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '9',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          child: TextFormField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            initialValue: '6',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                                initialValue: '100',
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(2)
                                ],
                                onSaved: (String? value) {},
                                validator: (String? value) => null,
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
                  onPressed: () {},
                  child: Text(
                    'Done',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RepField extends StatefulWidget {
  const RepField({Key? key}) : super(key: key);

  @override
  State<RepField> createState() => _RepFieldState();
}

class _RepFieldState extends State<RepField> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            onSaved: (String? value) {},
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
              onSaved: (String? value) {},
              validator: (String? value) => null,
            ),
          ),
        ],
        GestureDetector(
          child: Icon(isExpanded
              ? Icons.keyboard_arrow_up_outlined
              : Icons.keyboard_arrow_down_outlined),
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
        )
      ],
    );
  }
}
