import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/widgets/tasks_list.dart';

import '../blocs/bloc_exports.dart';

// ignore: must_be_immutable
class FavouriteTasksScreen extends StatelessWidget {
  const FavouriteTasksScreen({super.key});

  static const id = 'favourite_tasks_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.favouriteTasks;
        return Column(
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${tasksList.length} Tasks',
                )
              ),
            ),
            TasksList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
