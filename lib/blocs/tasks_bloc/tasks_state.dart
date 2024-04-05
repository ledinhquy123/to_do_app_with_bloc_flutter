part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({
    this.pendingTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.favouriteTasks = const <Task>[],
    this.removedTasks = const <Task>[]
  });

  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favouriteTasks;
  final List<Task> removedTasks;

  @override
  List<Object> get props => [
    pendingTasks,
    completedTasks,
    favouriteTasks,
    removedTasks
  ];

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((e) => e.toMap()).toList(),
      'completedTasks': completedTasks.map((e) => e.toMap()).toList(),
      'favouriteTasks': favouriteTasks.map((e) => e.toMap()).toList(),
      'removedTasks': removedTasks.map((e) => e.toMap()).toList()
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTasks: List<Task>.from(map['pendingTasks'].map((x) => Task.fromMap(x))),
      completedTasks: List<Task>.from(map['completedTasks'].map((x) => Task.fromMap(x))),
      favouriteTasks: List<Task>.from(map['favouriteTasks'].map((x) => Task.fromMap(x))),
      removedTasks: List<Task>.from(map['removedTasks'].map((x) => Task.fromMap(x)))
    );
  }
}