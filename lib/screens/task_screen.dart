import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/provider_model.dart';
import 'package:todo/screens/task_list.dart';

import 'add_task_screen.dart';

class TaskScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    bool isAddedTask = Provider.of<Data>(context).taskAdded;
    return Consumer<Data>(builder: (context, taskData, child) {
      return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 60, left: 30, bottom: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.list,
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'TO-DO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${taskData.taskCount} '
                    'Tasks',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  //shadow here
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: TaskList(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            showModalBottomSheet(
                context: context, builder: (context) => AddTaskScreen());
          },
//          onPressed: () async {
//            TaskDb rnd = testTodo[math.Random().nextInt(testTodo.length)];
//            await DBProvider.db.newToDo(rnd);
//            setState(() {});
//          },
          icon: Icon(Icons.add),
          label: Text('Add Task'),
          elevation: 2.0,
        ),
      );
    });
  }
}
