import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddRoutinePage extends ConsumerWidget {
  const AddRoutinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

final _providerOfName = StateProvider<String?>((ref) => null);
