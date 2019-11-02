import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_tracker/models/TaskModel.dart';
import 'package:task_tracker/utilities/Constants.dart';

class TaskDatabaseProvider {
  static Database database;

  static openDbConnection() async {
    database = await openDatabase(
      join(await getDatabasesPath(), DBKeys.DATABASE_NAME),
    );
  }

  static Future<bool> createTask(TaskViewModel newTask) async {
    if (database == null) await openDbConnection();

    var result = await database.insert(
      DBKeys.TASKS_TABLE_NAME,
      newTask.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result > 0;
  }

  static Future<List<TaskViewModel>> loadTasks() async {
    if (database == null) await openDbConnection();

    final List<Map<String, dynamic>> maps =
        await database.query(DBKeys.TASKS_TABLE_NAME);

    List<TaskViewModel> responseList = [];
    for (int i = 0; i < maps.length; i++)
      responseList.add(TaskViewModel.fromJson(maps[i]));

    return responseList;
  }

  static Future<bool> updateTask(TaskViewModel task) async {
    if (database == null) await openDbConnection();

    var result = await database.update(
      DBKeys.TASKS_TABLE_NAME,
      task.toMap(),
      where: "${DBKeys.ID_KEY} = ?",
      whereArgs: [task.taskId],
    );
    return result > 0;
  }

  static Future<bool> deleteTask(TaskViewModel task) async {
    if (database == null) await openDbConnection();

    var result = await database.delete(
      DBKeys.TASKS_TABLE_NAME,
      where: "${DBKeys.ID_KEY} = ?",
      whereArgs: [task.taskId],
    );
    return result > 0;
  }
}
