import 'package:task_tracker/models/CategoryModel.dart';
import 'package:task_tracker/models/TaskModel.dart';
import 'package:task_tracker/models/UserDataModel.dart';
import 'package:task_tracker/resources/LoginAPIs.dart';
import 'package:task_tracker/resources/database_provider/CategoryDatabaseProvider.dart';
import 'package:task_tracker/resources/database_provider/TaskDatabaseProvider.dart';

class Repository {
  //----------------- DB OPERATIONS ------------------------------
  static loadData() async {
    try {
      List<TaskViewModel> tasks = await TaskDatabaseProvider.loadTasks();
      List<CategoryViewModel> categories =
          await CategoryDatabaseProvider.loadCategories();

      return SingleUserDataModel(
        userCategories: categories,
        userTasks: tasks,
      );
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

  static Future<bool> updateNote({TaskViewModel note}) {
    try {
      return TaskDatabaseProvider.updateTask(note);
    } catch (ex) {
      print('Exception Accured While updating Data From DB => $ex');
      throw ex;
    }
  }

  static Future<bool> closeNote({TaskViewModel note}) {
    try {
      return TaskDatabaseProvider.closeTask(note);
    } catch (ex) {
      print('Exception Accured While updating Data From DB => $ex');
      throw ex;
    }
  }

  static Future<bool> addCategory({CategoryViewModel category}) {
    try {
      return CategoryDatabaseProvider.createCategory(category);
    } catch (ex) {
      print('Exception Accured While Loading Data From DB => $ex');
      throw ex;
    }
  }

  //----------------- FIRE-BASE OPERATIONS -------------------------

  static Future<void> requestAuthCode(
          {String phoneNumber,
          Function onVerificationComplete,
          Function onCodeSent,
          Function onVerificationTimeout,
          Function onAuthFailed}) async =>
      await LoginAPIs.requestPhoneAuthCode(
          phone: phoneNumber,
          onComplete: onVerificationComplete,
          onCode: onCodeSent,
          onError: onAuthFailed,
          onTimeout: onVerificationTimeout);
}
