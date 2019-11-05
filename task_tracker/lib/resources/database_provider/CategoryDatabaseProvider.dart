import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_tracker/models/CategoryModel.dart';
import 'package:task_tracker/utilities/Constants.dart';

class CategoryDatabaseProvider {
  static Database database;

  static openDbConnection() async {
    database = await openDatabase(
      join(await getDatabasesPath(), DBKeys.DATABASE_NAME),
    );
  }

  static Future<bool> createCategory(CategoryViewModel newCategory) async {
    if (database == null) await openDbConnection();

    var result = await database.insert(
      DBKeys.CATEGORY_TABLE_NAME,
      newCategory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result > 0;
  }

  static Future<List<CategoryViewModel>> loadCategories() async {
    if (database == null) await openDbConnection();

    final List<Map<String, dynamic>> maps =
        await database.query(DBKeys.CATEGORY_TABLE_NAME);

    List<CategoryViewModel> responseList = [];
    for (int i = 0; i < maps.length; i++)
      responseList.add(CategoryViewModel.fromJson(maps[i]));
    return responseList;
  }

  static Future<bool> updateCategory(CategoryViewModel category) async {
    if (database == null) await openDbConnection();

    var result = await database.update(
      DBKeys.CATEGORY_TABLE_NAME,
      category.toMap(),
      where: "${DBKeys.CATEGORY_ID_KEY} = ?",
      whereArgs: [category.categoryId],
    );
    return result > 0;
  }

  static Future<bool> deleteCategory(CategoryViewModel task) async {
    if (database == null) await openDbConnection();

    var result = await database.delete(
      DBKeys.CATEGORY_TABLE_NAME,
      where: "${DBKeys.CATEGORY_ID_KEY} = ?",
      whereArgs: [task.categoryId],
    );
    return result > 0;
  }
}
