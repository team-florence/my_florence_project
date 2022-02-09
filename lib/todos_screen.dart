import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_florence_project/edit_todo_screen.dart';
import 'package:my_florence_project/network_client.dart';
import 'package:my_florence_project/todo.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key key}) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  List<Todo> todos = [];

  @override
  void initState() {
    setTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // open create
          NetworkClient().createTodo("test");
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

      body: SingleChildScrollView(
        child: Column(
          children: todos
              .map((e) => GestureDetector(
                    onTap: () {
                      openActions(e.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.title,
                        textAlign: TextAlign.left, // ??
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  setTodos() async {
    final todoData = await NetworkClient().getTodos();
    todos = List<Todo>.from(json.decode(todoData).map((e) => Todo.from(e)));
  }

  openActions(int id) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView(
            children: [
              TextButton(
                onPressed: () async {
                  final result = await NetworkClient().deleteTodo(id);
                  if (result == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted!")));
                  }
                },
                child: Text("Delete"),
              ),
              TextButton(
                onPressed: () async {
                  final editedTodo =
                      await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    final todo = todos.firstWhere((element) => element.id == id);
                    return EditTodoScreen(todo: todo);
                  }));
                  final todoData = await NetworkClient().updateTodo(editedTodo);
                  final todo = Todo.from(json.decode(todoData));
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(todo.title),
                    backgroundColor: Colors.green,
                  ));
                },
                child: Text("Edit"),
              ),
            ],
          );
        });
  }
}
