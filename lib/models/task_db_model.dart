// To parse this JSON data, do
//
//ClientModel.dart
import 'dart:convert';

TaskDb taskDbFromJson(String str) {
  final jsonData = json.decode(str);
  return TaskDb.fromMap(jsonData);
}

String taskDbToJson(TaskDb data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class TaskDb {
  int id;
  String task;
  bool isDone;
  bool isDelete;

  TaskDb({
    this.id,
    this.task,
    this.isDone,
    this.isDelete,
  });

  factory TaskDb.fromMap(Map<String, dynamic> json) => new TaskDb(
        id: json["id"],
        task: json["task"],
        isDone: json["isDone"] == 1,
        isDelete: json["isDelete"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "task": task,
        "isDone": isDone,
        "isDelete": isDelete,
      };

//  void toggleDone() {
//    isDone = !isDone;
//  }
}
