import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/provider_model.dart';
import 'package:todo/screens/task_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      create: (context) => Data(),
      child: MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}
