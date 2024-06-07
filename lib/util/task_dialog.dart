import 'package:flutter/material.dart';

class TodoDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback addTodo;

  TodoDialog({required this.controller, required this.addTodo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Todo'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Enter todo'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            addTodo();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
