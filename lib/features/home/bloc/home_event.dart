import 'package:equatable/equatable.dart';
import '../../../features/home/domain/models/task_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

// Trigger when home page starts
class HomeStarted extends HomeEvent {
  final String uid;
  const HomeStarted(this.uid);

  @override
  List<Object?> get props => [uid];
}

// Triggered internally when tasks change
class TasksUpdated extends HomeEvent {
  final List<TaskModel> tasks;
  const TasksUpdated(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

// Add a new task
class AddTaskRequested extends HomeEvent {
  final String title;
  final String description;
  final DateTime due;

  const AddTaskRequested({
    required this.title,
    required this.description,
    required this.due,
  });

  @override
  List<Object?> get props => [title, description, due];
}

// Update status (Pending, In Progress, Completed)
class UpdateTaskStatusRequested extends HomeEvent {
  final String taskId;
  final String newStatus;
  const UpdateTaskStatusRequested(this.taskId, this.newStatus);

  @override
  List<Object?> get props => [taskId, newStatus];
}

// Delete a task
class DeleteTaskRequested extends HomeEvent {
  final String taskId;
  const DeleteTaskRequested(this.taskId);

  @override
  List<Object?> get props => [taskId];
}
