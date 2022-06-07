// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

List<Todo> list = [];

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.detail,
    required this.time,
  });

  String id;
  String title;
  String detail;
  DateTime time;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        title: json["title"],
        detail: json["detail"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "detail": detail,
        "time": time,
      };
}
