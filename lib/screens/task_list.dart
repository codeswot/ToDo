import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/db/database.dart';
import 'package:todo/models/task_db_model.dart';
import 'package:todo/provider/provider_model.dart';
import 'package:todo/screens/task_tile.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, taskData, child) {
      return FutureBuilder<List<TaskDb>>(
          future: DBProvider.db.getAllTodo(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TaskDb>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final task = taskData.tasks[index];
//                  TaskDb item = snapshot.data[index];
                  return TaskTile(
                    taskTitle: task.name,
                    isChecked: task.isDone,
                    checkBoxCallBack: (checkBoxState) {
                      taskData.updateTask(task);
                    },
                    deleteCallBack: () {
                      taskData.deleteTask(task);
                    },
                  );
                },
//                itemCount: snapshot.data.length,
                itemCount: taskData.taskCount,
              );
            } else {
              return Center(
                child: Text('Add something'),
              );
            }
          });
    });
  }
}
