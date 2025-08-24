import 'dart:async';
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
    on<HomeStarted>(_onStarted);
    on<TasksUpdated>((event, emit) {
      emit(state.copyWith(loading: false, tasks: event.tasks));
    });
    on<AddTaskRequested>(_onAddTask);
    on<UpdateTaskStatusRequested>(_onUpdateStatus);
    on<DeleteTaskRequested>(_onDeleteTask);
  }

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final name = await repo.getUserName(event.uid);
      emit(state.copyWith(userName: name));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }

    // Cancel previous subscription if any
    await _tasksSub?.cancel();

    // Listen to tasks stream
    _tasksSub = repo.tasksStream(event.uid).listen(
          (tasks) {
        // Instead of emit here, add a new event
        add(TasksUpdated(tasks));
      },
      onError: (e) {
        addError(e);
      },
    );
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