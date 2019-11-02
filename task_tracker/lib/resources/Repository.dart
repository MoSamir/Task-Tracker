import 'package:task_tracker/models/TaskModel.dart';
import 'package:task_tracker/resources/database_provider/TaskDatabaseProvider.dart';

class Repository {
  static loadData() {
    try {
      return TaskDatabaseProvider.loadTasks();
    } catch (ex) {
      print('Exception Accured While Loading Data From DB => $ex');
      throw ex;
    }
  }

  static Future<bool> addNote({TaskViewModel note}) {
    try {
      return TaskDatabaseProvider.createTask(note);
    } catch (ex) {
      print('Exception Accured While Loading Data From DB => $ex');
      throw ex;
    }
  }

  static Future<bool> deleteNote({TaskViewModel note}) {
    try {
      return TaskDatabaseProvider.deleteTask(note);
    } catch (ex) {
      print('Exception Accured While Deleting Data From DB => $ex');
      throw ex;
    }
  }
}
