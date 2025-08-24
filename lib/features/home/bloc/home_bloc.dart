import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/home/data/home_repository.dart';
import '../../../features/home/domain/models/task_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repo;
  StreamSubscription<List<TaskModel>>? _tasksSub;
  String? _uid;

  HomeBloc({required this.repo}) : super(const HomeState()) {
    on<HomeStarted>(_onHomeStarted);
    on<TasksUpdated>(_onTasksUpdated);
    on<AddTaskRequested>(_onAddTask);
    on<UpdateTaskStatusRequested>(_onUpdateStatus);
    on<DeleteTaskRequested>(_onDeleteTask);
  }

  /// Called when Home page starts
  Future<void> _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loading: true));
    _uid = event.uid; // store UID for task operations

    // Get user info
    final authUser = FirebaseAuth.instance.currentUser;
    String userName = authUser?.displayName ?? authUser?.email?.split('@')[0] ?? 'User';

    // Fetch user document
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(event.uid).get();
    if (userDoc.exists) {
      final data = userDoc.data()!;
      userName = data['name'] ?? userName;
    }

    // Fetch teams
    final teams = await repo.getUserTeams(event.uid);

    // Emit initial state (userName + teams)
    emit(state.copyWith(
      loading: false,
      userName: userName,
      teams: teams,
    ));

    // Subscribe to tasks from subcollection
    _tasksSub?.cancel();
    _tasksSub = repo.tasksStream(event.uid).listen(
          (tasks) => add(TasksUpdated(tasks)),
      onError: (e) => emit(state.copyWith(error: e.toString())),
    );
  }

  /// Update tasks in state
  void _onTasksUpdated(TasksUpdated event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      tasks: event.tasks,
      loading: false,
    ));
  }

  /// Add a new task
  Future<void> _onAddTask(AddTaskRequested event, Emitter<HomeState> emit) async {
    if (_uid == null) return;
    try {
      await repo.addTask(
        _uid!,
        title: event.title,
        description: event.description,
        due: event.due,
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Update task status
  Future<void> _onUpdateStatus(UpdateTaskStatusRequested event, Emitter<HomeState> emit) async {
    if (_uid == null) return;
    try {
      await repo.updateTaskStatus(_uid!, event.taskId, event.newStatus);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Delete task
  Future<void> _onDeleteTask(DeleteTaskRequested event, Emitter<HomeState> emit) async {
    if (_uid == null) return;
    try {
      await repo.deleteTask(_uid!, event.taskId);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _tasksSub?.cancel();
    return super.close();
  }
}
