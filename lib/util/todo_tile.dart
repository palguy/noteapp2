import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element
// ignore_for_file: sort_child_properties_last

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final VoidCallback? onEdit;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // CheckBox
            Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
            ),

            // Task Name
            Expanded(
              child: Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted ? TextDecoration.lineThrough : null,
                  fontSize: 16,
                ),
              ),
            ),

            // Edit Button
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blueAccent),
              onPressed: onEdit,
              tooltip: "تعديل",
            ),

            // Delete Button
            // IconButton(
            //   icon: const Icon(Icons.delete, color: Colors.red),
            //   onPressed: () {
            //     if (deleteFunction != null) deleteFunction!(context);
            //   },
            //   tooltip: "حذف",
            // ),
          ],
        ),
      ),
    );
  }
}
