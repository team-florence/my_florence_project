class Todo {
  int id;
  String title;
  bool completed;
  int userId;

  Todo({this.title, this.completed, this.userId, this.id});

  Todo.from(Map<String, dynamic> data)
      : id = data["id"],
        title = data["title"],
        completed = data["completed"],
        userId = data["user_id"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "user_id": userId,
      "completed": completed,
    };
  }
}
