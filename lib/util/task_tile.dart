import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final List todo;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete;

  TodoTile({
    required this.todo,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo[0],
        style: TextStyle(
          decoration:
              todo[1] ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        value: todo[1],
        onChanged: onChanged,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
