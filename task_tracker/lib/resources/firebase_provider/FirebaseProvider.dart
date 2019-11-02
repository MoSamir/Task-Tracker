import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_tracker/models/TaskModel.dart';
import 'package:task_tracker/utilities/Constants.dart';

class BackupController {
  static Future<void> backupDB(List<TaskViewModel> databaseModels) async {
    Firestore firebaseInstance = Firestore.instance;
    firebaseInstance
        .collection(DBKeys.FIRE_STORE_BASE_TABLE_NAME)
        .document('Mohamed')
        .delete()
        .then((v) {
      databaseModels.forEach((task) {
        firebaseInstance
            .collection(DBKeys.FIRE_STORE_BASE_TABLE_NAME)
            .document('Mohamed')
            .collection(DBKeys.FIRE_sTORE_USER_TABLE_NAME)
            .add(task.toCloudMap());
      });
    });
  }
}
