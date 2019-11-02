import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_tracker/utilities/Constants.dart';

class DatabaseProvider {
  static createDb() async {
    openDatabase(
      join(await getDatabasesPath(), DBKeys.DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE ${DBKeys.TASKS_TABLE_NAME}(${DBKeys.ID_KEY} ${DBKeys.INT_DT} PRIMARY KEY AUTOINCREMENT,"
          " ${DBKeys.TASK_NAME_KEY} ${DBKeys.TXT_DT},"
          " ${DBKeys.TASK_DESCRIPTION_KEY} ${DBKeys.TXT_DT} ,"
          " ${DBKeys.TASK_PRIORITY_KEY} ${DBKeys.TXT_DT})",
        );
      },
      version: 2,
    );
  }
}
