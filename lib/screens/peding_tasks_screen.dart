import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/widgets/tasks_list.dart';

import '../blocs/bloc_exports.dart';

// ignore: must_be_immutable
class PedingTasksScreen extends StatelessWidget {
  const PedingTasksScreen({super.key});

  static const id = 'tasks_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> pedingTasks = state.pendingTasks;
        List<Task> completedTasks = state.completedTasks;
        return Column(
          children: [
            Center(
              child: Chip(
                label: Text(
                  '${pedingTasks.length} Peding | ${completedTasks.length} Completed',
                )
              ),
            ),
            TasksList(tasksList: pedingTasks)
          ],
        );
      },
    );
  }
}
