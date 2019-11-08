import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_tracker/bloc/DataBloc.dart';
import 'package:task_tracker/models/CategoryModel.dart';
import 'package:task_tracker/resources/database_provider/CategoryDatabaseProvider.dart';
import 'package:task_tracker/utilities/Constants.dart';

class DatabaseProvider {
  static createDb({DataBloc bloc}) async {
    await openDatabase(
      join(await getDatabasesPath(), DBKeys.DATABASE_NAME),
      onCreate: (db, version) {
        print('Is db open ? => ${db.isOpen}');
        db.execute(
            "CREATE TABLE ${DBKeys.TASKS_TABLE_NAME} ( ${DBKeys.TASK_ID_KEY} ${DBKeys.INT_DT} PRIMARY KEY AUTOINCREMENT ,"
            " ${DBKeys.TASK_NAME_KEY} ${DBKeys.TXT_DT} ,"
            " ${DBKeys.TASK_DESCRIPTION_KEY} ${DBKeys.TXT_DT} ,"
            " ${DBKeys.TASK_CREATION_DATE_KEY} ${DBKeys.TXT_DT} ,"
            " ${DBKeys.TASK_COMPLETION_DATE_KEY} ${DBKeys.TXT_DT} ,"
            " ${DBKeys.TASK_STATUES_KEY} ${DBKeys.INT_DT} ,"
            " ${DBKeys.TASK_PRIORITY_KEY} ${DBKeys.TXT_DT} ) ; ");
        db.execute(
            " CREATE TABLE ${DBKeys.CATEGORY_TABLE_NAME} ( ${DBKeys.CATEGORY_ID_KEY} ${DBKeys.INT_DT} PRIMARY KEY AUTOINCREMENT ,"
            " ${DBKeys.CATEGORY_NAME_KEY} ${DBKeys.TXT_DT} ,"
            " ${DBKeys.CATEGORY_COLOR_KEY} ${DBKeys.TXT_DT} ) ;");
      },
      singleInstance: true,
      version: 8,
    );

    CategoryDatabaseProvider.createCategory(CategoryViewModel(
        categoryId: 1, categoryName: 'Work', categoryColor: '0xFF745c97'));
    CategoryDatabaseProvider.createCategory(CategoryViewModel(
      categoryId: 2,
      categoryName: 'Personal',
      categoryColor: '0xFFFF9800',
    ));
    CategoryDatabaseProvider.createCategory(CategoryViewModel(
      categoryId: 3,
      categoryName: 'Health',
      categoryColor: '0xFF80D8FF',
    ));
    bloc.add(LoadNotes());
  }
}
