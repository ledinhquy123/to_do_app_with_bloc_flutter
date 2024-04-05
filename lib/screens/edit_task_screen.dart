import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';

import '../blocs/bloc_exports.dart';

// ignore: must_be_immutable
class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  TextEditingController? titleController;
  TextEditingController? descriptionController;

  EditTaskScreen({
    required this.oldTask,
    this.titleController,
    this.descriptionController,
    super.key,
  }) {
    titleController = TextEditingController(
      text: oldTask.title
    );
    descriptionController = TextEditingController(
      text: oldTask.description
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Edit Task',
            style: TextStyle(
              fontSize: 24
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder()
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            autofocus: true,
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              label: Text('Description'),
              border: OutlineInputBorder()
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: const Text('Cancel')
              ),
              ElevatedButton(
                onPressed: () {
                  var editedTask = Task(
                    id: oldTask.id, 
                    title: titleController!.text,
                    description: descriptionController!.text,
                    isFavourite: oldTask.isFavourite,
                    isDone: false,
                    date: DateTime.now().toString()
                  );
                  // In here, edit task
                  context
                  .read<TasksBloc>()
                  .add(EditTask(oldTask: oldTask, newTask: editedTask));
                  
                  Navigator.pop(context);
                }, 
                child: const Text('Save')
              )
            ],
          ),
        ],
      ),
    );
  }
}