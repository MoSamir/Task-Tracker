import 'package:task_tracker/utilities/Constants.dart';

class CategoryViewModel {
  var categoryId;
  var categoryName, categoryColor;
  CategoryViewModel({this.categoryColor, this.categoryId, this.categoryName});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> categoryMap = {
      DBKeys.CATEGORY_NAME_KEY: categoryName,
      DBKeys.CATEGORY_COLOR_KEY: categoryColor,
    };

    if (this.categoryId != null)
      categoryMap.putIfAbsent(DBKeys.CATEGORY_ID_KEY, () => categoryId);
    return categoryMap;
  }

  Map<String, dynamic> toCloudMap() {
    return {
      DBKeys.CATEGORY_ID_KEY: categoryId.toString(),
      DBKeys.CATEGORY_NAME_KEY: categoryName,
      DBKeys.CATEGORY_COLOR_KEY: categoryColor,
    };
  }

  static CategoryViewModel fromJson(Map<String, dynamic> json) {
    return CategoryViewModel(
      categoryId:
          json[DBKeys.CATEGORY_ID_KEY] != null ? [DBKeys.CATEGORY_ID_KEY] : 0,
      categoryName: json[DBKeys.CATEGORY_NAME_KEY] != null
          ? json[DBKeys.CATEGORY_NAME_KEY]
          : '',
      categoryColor: json[DBKeys.CATEGORY_COLOR_KEY] != null
          ? json[DBKeys.CATEGORY_COLOR_KEY]
          : '',
    );
  }
}
