import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/screens/edit_task_screen.dart';
import 'package:to_do_app/widgets/popup_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted == true
      ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
      : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom // Get the emulator's keyboard height 
          ),
          child: EditTaskScreen(oldTask: task),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavourite == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: task.isDone == false 
                            ? TextDecoration.none 
                            : TextDecoration.lineThrough
                        ),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy hh:mm:ss')
                        .format(DateTime.parse(task.date))
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        
          Row(
            children: [
              Checkbox(
                value: task.isDone, 
                // If not checked then updateTask will fail due to index invalid
                onChanged: task.isDeleted == false 
                  ? (value) {
                    context
                      .read<TasksBloc>()
                      .add(UpdateTask(task: task));
                  }
                  : null,
              ),
              PopupMenu(
                task: task,
                cancelOrDeleteCallback: () => _removeOrDeleteTask(context, task),
                likeOrDislikeCallback: () => context
                  .read<TasksBloc>()
                  .add(MarkFavouriteOrUnfavouriteTask(task: task)),
                editTaskCallback: () => _editTask(context),
                restoreTaskCallback: () => context
                  .read<TasksBloc>()
                  .add(RestoreTask(task: task)),
              )
            ],
          ),
        ],
      ),
    );
  }
}



// ListTile(
//       title: Text(
//         task.title,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           decoration: task.isDone == false 
//             ? TextDecoration.none 
//             : TextDecoration.lineThrough
//         ),
//       ),
//       trailing: Checkbox(
//         value: task.isDone, 
//         // If not checked then updateTask will fail due to index invalid
//         onChanged: task.isDeleted == false 
//           ? (value) {
//             context
//               .read<TasksBloc>()
//               .add(UpdateTask(task: task));
//           }
//           : null,
//       ),
//       onLongPress: () => _removeOrDeleteTask(context, task),
//     )