import 'package:equatable/equatable.dart';
import 'package:to_do_app/blocs/bloc_exports.dart';
import 'package:to_do_app/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

// Use HydratedBloc to keep my data
class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavouriteOrUnfavouriteTask>(_onMarkFavouriteOrunFavouriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }

  // This function will resolve event addTask and emit the state
  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state; // now state in application
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task), // Append of the List
        completedTasks: state.completedTasks,
        favouriteTasks: state.favouriteTasks,
        removedTasks: state.removedTasks
      )
    );
  }

  // This function will resolve event updateTask and emit the state
  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;

    if(task.isDone == false) {
      // Case peding tasks
      if(task.isFavourite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(0, task.copyWith(isDone: true));
      } else {
        var taskIndex = favouriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(0, task.copyWith(isDone: true));
        favouriteTasks
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      // Case completed tasks
      if(task.isFavourite == false) {
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks.insert(0, task.copyWith(isDone: false));
      } else {
        var taskIndex = favouriteTasks.indexOf(task);
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks.insert(0, task.copyWith(isDone: false));
        favouriteTasks
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false));
      }
    }

    emit(
      TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favouriteTasks: favouriteTasks,
        removedTasks: state.removedTasks
      )
    );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks),
      completedTasks: state.completedTasks,
      favouriteTasks: state.favouriteTasks,
      removedTasks: List.from(state.removedTasks)..remove(task)
    ));
  }
  
  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    // Remove all in lists
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..remove(task),
      completedTasks: List.from(state.completedTasks)..remove(task),
      favouriteTasks: List.from(state.favouriteTasks)..remove(task),
      removedTasks: List.from(state.removedTasks)..add(task.copyWith(isDeleted: true))
    ));
  }

  void _onMarkFavouriteOrunFavouriteTask(
    MarkFavouriteOrUnfavouriteTask event, 
    Emitter<TasksState> emit
  ) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favouriteTasks;

    if(event.task.isDone == false) {
      // Case peding tasks
      if(event.task.isFavourite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    } else {
      // Case completed tasks
      if(event.task.isFavourite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: true));
        favouriteTasks.insert(0, event.task.copyWith(isFavourite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavourite: false));
        favouriteTasks.remove(event.task);
      }
    }

    emit(
      TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favouriteTasks: favouriteTasks,
        removedTasks: state.removedTasks
      )
    );
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favouriteTasks;
    if(event.oldTask.isFavourite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTasks: state.completedTasks..remove(event.oldTask),
      favouriteTasks: favouriteTasks,
      removedTasks: state.removedTasks
    ));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      pendingTasks: List.from(state.pendingTasks)
        ..insert(
          0, 
          event.task.copyWith(
            isDeleted: false,
            isDone: false,
            isFavourite: false
          )
        ),
      completedTasks: state.completedTasks,
      favouriteTasks: state.favouriteTasks
    ));
  }

  void _onDeleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..clear(),
      pendingTasks: state.pendingTasks,
      favouriteTasks: state.favouriteTasks,
      completedTasks: state.completedTasks,
    ));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }
  
  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
