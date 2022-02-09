import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_florence_project/todo.dart';

class NetworkClient {
  // GETS Users
  getUsers() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users/');
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  // GETS Todos: Gets all todos
  Future<dynamic> getTodos() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/');
    var response = await http.get(url);
    return response.body;
  }

  // PUTS Todos: Updates a _todo
  Future<dynamic> updateTodo(Todo todo) async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo.id}');
    var body = json.encode(todo.toMap());
    var response = await http.put(url, headers: {"Content-Type": "application/json"}, body: body);
    return response.body;
  }

  // POST Todos: Creates a new _todo
  createTodo(String title) async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/');
    final body = json.encode({"titles": title});
    var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  // DELETE Todos: Deletes a _todo
  Future<bool> deleteTodo(int id) async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/$id');
    var response = await http.delete(url);
    return response.statusCode == 200;
  }
}
