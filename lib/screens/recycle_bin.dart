import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/screens/my_drawer.dart';
import 'package:to_do_app/widgets/tasks_list.dart';

import '../blocs/bloc_exports.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});

  static const id = 'recycle_bin_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> binTasks = state.removedTasks;
        return Scaffold(
            appBar: AppBar(
              title: const Text('Recycle Bin'),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () => context.read<TasksBloc>().add(DeleteAllTasks()),
                      child: TextButton.icon(
                        onPressed: null, 
                        icon: const Icon(Icons.delete_forever), 
                        label: const Text('Delete all tasks')
                      )
                    )
                  ]
                )
              ],
            ),
            drawer: MyDrawer(),
            body: Column(
              children: [
                Center(
                  child: Chip(
                      label: Text(
                        '${binTasks.length} Tasks',
                      )
                  ),
                ),
                TasksList(tasksList: binTasks)
              ],
            ));
      },
    );
  }
}
