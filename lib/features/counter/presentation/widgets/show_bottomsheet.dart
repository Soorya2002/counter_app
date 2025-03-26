import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter_app/features/counter/provider/counter_provider.dart';

class ShowBottomSheet extends StatelessWidget {
  final VoidCallback onCounterAdded; // Callback function

  const ShowBottomSheet({super.key, required this.onCounterAdded});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController countController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),

          // Title Input Field
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Title"),
          ),
          SizedBox(height: 12),

          // Count Input Field
          TextField(
            controller: countController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Count"),
          ),
          SizedBox(height: 16),

          // Add Counter Button
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final count = int.tryParse(countController.text) ?? 0;

                if (title.isNotEmpty) {
                  await context.read<CounterProvider>().addCounter(
                    title,
                    count,
                  );
                  onCounterAdded(); // Refresh counter list after adding
                  Navigator.pop(context); // Close Bottom Sheet
                }
              },
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }

  /// Function to show the bottom sheet
  static void show(
    BuildContext context, {
    required VoidCallback onCounterAdded,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ShowBottomSheet(onCounterAdded: onCounterAdded),
    );
  }
}
