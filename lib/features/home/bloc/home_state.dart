import '../../../features/home/domain/models/task_model.dart';

class HomeState {
  final String? userName;
  final bool loading;
  final List<TaskModel> tasks;
  final List<String> teamIds;
  final String? error;

  HomeState({
    this.userName,
    this.loading = false,
    this.tasks = const [],
    this.teamIds = const [],
    this.error,
  });

  HomeState copyWith({
    String? userName,
    bool? loading,
    List<TaskModel>? tasks,
    List<String>? teamIds,
    String? error,
  }) {
    return HomeState(
      userName: userName ?? this.userName,
      loading: loading ?? this.loading,
      tasks: tasks ?? this.tasks,
      teamIds: teamIds ?? this.teamIds,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [userName, loading, tasks, teamIds, error];
}