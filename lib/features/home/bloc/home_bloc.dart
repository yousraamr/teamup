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

  HomeBloc({required this.repo}) : super(HomeState()) {
    on<HomeStarted>(_onHomeStarted);
    on<TasksUpdated>((event, emit) {
      emit(state.copyWith(loading: false, tasks: event.tasks));
    });
    on<AddTaskRequested>(_onAddTask);
    on<UpdateTaskStatusRequested>(_onUpdateStatus);
    on<DeleteTaskRequested>(_onDeleteTask);
  }

  Future<void> _onHomeStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loading: true));

    final authUser = FirebaseAuth.instance.currentUser;
    String userName = authUser?.displayName ?? authUser?.email?.split('@')[0] ?? 'User';

    // Fetch Firestore document if it exists
    final doc = await FirebaseFirestore.instance.collection('users').doc(event.uid).get();
    List<String> teamIds = [];
    List<TaskModel> tasks = [];

    if (doc.exists) {
      final data = doc.data()!;
      userName = data['name'] ?? userName; // use Firestore name if available
      tasks = (data['tasks'] as List<dynamic>? ?? [])
          .map((t) => TaskModel(
        id: t['id'] ?? '',
        title: t['title'] ?? '',
        description: t['description'] ?? '',
        status: t['status'] ?? 'pending',
        dueDate: t['dueDate'] != null ? (t['dueDate'] as Timestamp).toDate() : null,
      ))
          .toList();
    }

    emit(state.copyWith(
      loading: false,
      userName: userName,
      tasks: tasks,
      teamIds: teamIds,
    ));
  }

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

  Future<void> _onUpdateStatus(UpdateTaskStatusRequested event, Emitter<HomeState> emit) async {
    if (_uid == null) return;
    try {
      await repo.updateTaskStatus(_uid!, event.taskId, event.newStatus);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

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