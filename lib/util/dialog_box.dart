// File: lib/util/dialog_box.dart
import 'package:flutter/material.dart';
import 'package:todoapp/data/saved_phrases_manager.dart';
import 'package:todoapp/util/my_button.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element
// ignore_for_file: sort_child_properties_last

class DialogBox extends StatelessWidget {
  final TextEditingController myController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  // Add a property to receive the SavedPhrasesManager instance
  final SavedPhrasesManager phrasesManager;

  DialogBox({
    super.key,
    required this.myController,
    required this.onSave,
    required this.onCancel,
    required this.phrasesManager, // Require the manager instance
  });

  void _appendPhrase(String phrase) {
    final currentText = myController.text;
    if (currentText.isEmpty) {
      myController.text = phrase;
    } else {
      myController.text = "$currentText $phrase";
    }
    myController.selection = TextSelection.fromPosition(
      TextPosition(offset: myController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      content: SizedBox(
        height: 260, // زيادة الارتفاع قليلاً
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                controller: myController,
                decoration: InputDecoration(
                  hintText: "Add a new task",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // النصوص المحفوظة - Now using the manager's phrases
              Text(
                "اختصر المهمة باستخدام:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                // Use the phrases from the manager instance
                children: phrasesManager.phrases.map((phrase) {
                  return ActionChip(
                    label: Text(phrase),
                    onPressed: () => _appendPhrase(phrase),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black, fontSize: 12),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              // أزرار الحفظ والإلغاء
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(text: 'Save', onPressed: onSave),
                  const SizedBox(width: 12),
                  MyButton(text: 'Cancel', onPressed: onCancel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
