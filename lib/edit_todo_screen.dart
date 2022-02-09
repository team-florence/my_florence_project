import 'package:flutter/material.dart';
import 'package:my_florence_project/todo.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;

  const EditTodoScreen({Key key, this.todo}) : super(key: key);

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  String textValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Center(
            child: Column(
              children: [
                Text("Current todo title:"),
                Text(widget.todo.title),
                SizedBox(height: 80),
                Text("New value"),
                TextField(
                  onChanged: (val) {
                    textValue = val;
                  },
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(Todo(
                        id: widget.todo.id,
                        title: textValue,
                        userId: widget.todo.userId,
                        completed: widget.todo.completed,
                      ));
                    },
                    child: Text("Submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
