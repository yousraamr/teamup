import 'package:equatable/equatable.dart';
import '../../../features/home/domain/models/task_model.dart';

class HomeState extends Equatable {
  final bool loading;
  final List<TaskModel> tasks;
  final String? error;
  final String? userName;
  final List<String> teamIds;

  const HomeState({
    this.loading = false,
    this.tasks = const [],
    this.error,
    this.userName,
  this.teamIds = const [], // initialize with empty list
  });

  HomeState copyWith({
    bool? loading,
    List<TaskModel>? tasks,
    String? error,
    String? userName,
    List<String>? teamIds,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      tasks: tasks ?? this.tasks,
      error: error,
      userName: userName ?? this.userName,
      teamIds: teamIds ?? this.teamIds,
    );
  }

  @override
  List<Object?> get props => [loading, tasks, error, userName, teamIds];
}