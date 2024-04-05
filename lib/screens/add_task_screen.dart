import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/services/gui_gen.dart';

import '../blocs/bloc_exports.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({
    super.key,
  });

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Add Task',
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
                  var task = Task(
                    id: GUIDGen.generate(), 
                    title: titleController.text,
                    description: descriptionController.text,
                    date: DateTime.now().toString()
                  );
                  // In here, add task
                  context
                  .read<TasksBloc>()
                  .add(AddTask(task: task));
                  
                  Navigator.pop(context);
                }, 
                child: const Text('Add')
              )
            ],
          ),
        ],
      ),
    );
  }
}