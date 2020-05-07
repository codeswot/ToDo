import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.checkBoxCallBack,
      this.deleteCallBack});
  final bool isChecked;
  final String taskTitle;
  final Function checkBoxCallBack;
  final Function deleteCallBack;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        child: IconButton(
          onPressed: deleteCallBack,
          icon: Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
        ),
      ),
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.blueAccent,
        value: isChecked,
        onChanged: checkBoxCallBack,
      ),
    );
  }
}
