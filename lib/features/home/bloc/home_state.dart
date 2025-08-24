import 'package:equatable/equatable.dart';
import '../../../features/home/domain/models/task_model.dart';

class HomeState extends Equatable {
  final String? userName;
  final bool loading;
  final List<TaskModel> tasks;
  final List<Map<String, String>> teams; // each map has id, name, initials
  final String? error;

  const HomeState({
    this.userName,
    this.loading = false,
    this.tasks = const [],
    this.teams = const [],
    this.error,
  });

  HomeState copyWith({
    String? userName,
    bool? loading,
    List<TaskModel>? tasks,
    List<Map<String, String>>? teams,
    String? error,
  }) {
    return HomeState(
      userName: userName ?? this.userName,
      loading: loading ?? this.loading,
      tasks: tasks ?? this.tasks,
      teams: teams ?? this.teams,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [userName, loading, tasks, teams, error];
}
