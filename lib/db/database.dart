import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task_db_model.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Task.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ToDo ("
          "id INTEGER PRIMARY KEY,"
          "task TEXT,"
          "isDone BIT,"
          "isDelete BIT"
          ")");
    });
  }

  newToDo(TaskDb newTask) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM ToDo");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into ToDo (id,task,isDone,isDelete)"
        " VALUES (?,?,?,?)",
        [id, newTask.task, newTask.isDone, newTask.isDelete]);
    return raw;
  }

  doneToDo(TaskDb taskRef) async {
    final db = await database;
    TaskDb blocked = TaskDb(
        id: taskRef.id,
        task: taskRef.task,
        isDone: taskRef.isDone,
        isDelete: !taskRef.isDelete);
    var res = await db.update("ToDo", blocked.toMap(),
        where: "id = ?", whereArgs: [taskRef.id]);
    return res;
  }

  updateTask(TaskDb newTask) async {
    final db = await database;
    var res = await db.update("ToDo", newTask.toMap(),
        where: "id = ?", whereArgs: [newTask.id]);
    return res;
  }

  getDone(int id) async {
    final db = await database;
    var res = await db.query("ToDo", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? TaskDb.fromMap(res.first) : null;
  }

  Future<List<TaskDb>> getDoneToDo() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("ToDo", where: "isDone = ? ", whereArgs: [1]);

    List<TaskDb> list =
        res.isNotEmpty ? res.map((c) => TaskDb.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<TaskDb>> getAllTodo() async {
    final db = await database;
    var res = await db.query("ToDo");
    List<TaskDb> list =
        res.isNotEmpty ? res.map((c) => TaskDb.fromMap(c)).toList() : [];
    return list;
  }

  deleteToDo(int id) async {
    final db = await database;
    return db.delete("ToDo", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from ToDo");
  }
}

List<TaskDb> testTodo = [
  TaskDb(task: "Raouf", isDone: true, isDelete: true),
  TaskDb(task: "Get Mushroom", isDone: false, isDelete: false),
  TaskDb(task: "Sleep", isDone: false, isDelete: false),
  TaskDb(task: "Code", isDone: true, isDelete: false),
];
