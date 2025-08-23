import 'package:flutter/material.dart';

class TaskListSection extends StatelessWidget {
  final List<Map<String, String>> tasks;

  const TaskListSection({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "My Tasks",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...tasks.map((task) {
          final isCompleted = task["status"] == "completed";
          return ListTile(
            leading: Icon(
              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isCompleted ? Colors.green : Colors.orange,
            ),
            title: Text(task["title"]!),
            subtitle: Text("Status: ${task["status"]}"),
          );
        }).toList(),
      ],
    );
  }
}
