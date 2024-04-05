import 'package:flutter/material.dart';
import 'package:to_do_app/models/task.dart';

class PopupMenu extends StatelessWidget {
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  final Task task;

  const PopupMenu({
    super.key,
    required this.task,
    required this.cancelOrDeleteCallback, 
    required this.likeOrDislikeCallback,
    required this.editTaskCallback,
    required this.restoreTaskCallback
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false 
      ? (context) => [
        PopupMenuItem(
          onTap: editTaskCallback,
          child: TextButton.icon(
            onPressed: null, 
            icon: const Icon(Icons.edit), 
            label: const Text('Edit')
          ),
        ),
        PopupMenuItem(
          onTap: likeOrDislikeCallback,
          child: TextButton.icon(
            onPressed: null, 
            icon: task.isFavourite == false
              ? const Icon(Icons.bookmark_add_outlined)
              : const Icon(Icons.bookmark_remove), 
            label: task.isFavourite == false
              ? const Text('Add to\nBookmarks')
              : const Text('Remove from\nBookmarks')
          ),
        ),
        PopupMenuItem(
          onTap: cancelOrDeleteCallback,
          child: TextButton.icon(
            onPressed: null, 
            icon: const Icon(Icons.delete), 
            label: const Text('Delete')
          ),
        )
      ]
      : (context) => [
        PopupMenuItem(
          onTap: restoreTaskCallback,
          child: TextButton.icon(
            onPressed: null, 
            icon: const Icon(Icons.restore), 
            label: const Text('Restore')
          )
        ),
        PopupMenuItem(
          onTap: cancelOrDeleteCallback,
          child: TextButton.icon(
            onPressed: null, 
            icon: const Icon(Icons.delete_forever), 
            label: const Text('Delete Forever')
          ),
        )
      ]
    );
  }
}