import 'package:flutter/material.dart';
import '../../../../constants.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String status;
  final String dueDate;

  const TaskCard({
    super.key,
    required this.title,
    required this.status,
    required this.dueDate,
  });

  Color getStatusColor() {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      case "Pending":
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: getStatusColor().withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              status,
              style: body.copyWith(
                color: getStatusColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(title, style: body.copyWith(fontWeight: FontWeight.w500)),
          ),
          Text(dueDate, style: body),
        ],
      ),
    );
  }
}
