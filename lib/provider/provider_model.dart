import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';

class Data extends ChangeNotifier {
  List<Task> _tasks = [];
  bool taskAdded;

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    if (_tasks.length > 0) {
      taskAdded = true;
    }
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    if (_tasks.length == 0) {
      taskAdded = false;
    }
    _tasks.remove(task);
    notifyListeners();
  }
}
