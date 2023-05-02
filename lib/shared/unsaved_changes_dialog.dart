import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:progressive_overload_app/main.dart';

class UnsavedChangesDialog extends StatelessWidget {
  const UnsavedChangesDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 5),
            Text(
              'Unsaved changes will be lost.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 20),
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
                    child: const Icon(
                      Icons.check_rounded,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Icon(
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
  }
}
