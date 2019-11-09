import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task_tracker/models/CategoryModel.dart';

class Constants {
  static const ONE_SIGNAL_ID = "2ab8756f-5831-45ad-9d1b-18bb85258598";
}

class Strings {
  static const ALL_NOTES = "All Notes";
  static const ADD_TASK = "Add Task";
  static const HOME = "Home";

  //-------------- ADD TASK --------------------
  static const TASK_NAME_HINT = "Name your task";
  static const TASK_CATEGORY_LABEL = "Choose category";
  static const TASK_DESCRIPTION_LABEL = "Write short description";
  static const TASK_DESCRIPTION_HINT = "Message ...";
  static const SAVE_TASK_BUTTON_TEXT = "Save Task";
  static const SAVE_TASK_SUCCESS_MESSAGE = "Task saved successfully";
  static const SAVE_TASK_FAILED_MESSAGE = "Something went wrong";
  static const REQUIRED_FIELD_ERROR = "Task name is required";

// -------------------Close Task---------------------------------

  static const CLOSE_TASK_TITLE = "Close Task";
  static const CLOSE_BUTTON_LABEL = "Close";
}

class Assets {
  static const NO_ITEMS_PLACEHOLDER = "assets/images/no_items.png";
  static const NOT_FOUND = "assets/images/404_not_found.png";
  static const SAVING_ERROR = "assets/images/saving_error.png";
}

class AppColors {
  static const APP_COLOR = Color(0xFF745c97);
  static const WHITE_COLOR = Colors.white;
  static const BLACK_COLOR = Colors.black;
  static const CLOSED_TASK_COLOR = Colors.grey;
}

class DBKeys {
  static const DATABASE_NAME = "task_project_database.db";
  static const INT_DT = "INTEGER";
  static const TXT_DT = "TEXT";

  // ------------ Task table -----------------------

  static const TASKS_TABLE_NAME = "task_tbl";
  static const TASK_ID_KEY = "task_id";
  static const TASK_NAME_KEY = "task_name";
  static const TASK_DESCRIPTION_KEY = "task_description";
  static const TASK_PRIORITY_KEY = "task_priority";
  static const TASK_CREATION_DATE_KEY = "task_creation_date";
  static const TASK_COMPLETION_DATE_KEY = "task_end_date";
  static const TASK_STATUES_KEY = "task_statues";

  // ----------- Firebase keys ----------------------

  static const FIRE_STORE_BASE_TABLE_NAME = "User";
  static const FIRE_STORE_USER_TASK_TABLE_NAME = "Tasks";
  static const FIRE_STORE_USER_CATEGORY_TABLE_NAME = "Categories";

//  ----------------------------------------------------

  static const CATEGORY_TABLE_NAME = "categories_tbl";
  static const CATEGORY_ID_KEY = "cat_id";
  static const CATEGORY_NAME_KEY = "cat_name";
  static const CATEGORY_COLOR_KEY = "cat_color";
}

class UtilityFunctions {
  static resolveTaskTypeToColor(
      String taskType, List<CategoryViewModel> userCategories) {
    for (int i = 0; i < userCategories.length; i++)
      if (taskType == userCategories[i].categoryName)
        return userCategories[i].categoryColor;
    return AppColors.APP_COLOR;
  }

  static isDarkColor(Color color) {
    double darkness = 1 -
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    if (darkness < 0.5) {
      return false; // It's a light color
    } else {
      return true; // It's a dark color
    }
  }
}
