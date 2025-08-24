import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status; // "pending" | "in_progress" | "completed"
  final DateTime? dueDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
  });

  factory TaskModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final due = data['dueDate'];
    DateTime? dueDt;
    if (due is Timestamp) dueDt = due.toDate();
    else if (due is DateTime) dueDt = due;
    return TaskModel(
      id: doc.id,
      title: (data['title'] ?? '') as String,
      description: (data['description'] ?? '') as String,
      status: (data['status'] ?? 'pending') as String,
      dueDate: dueDt,
    );
  }
}