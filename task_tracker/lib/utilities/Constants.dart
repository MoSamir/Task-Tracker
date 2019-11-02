import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {}

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
  static const TASK_TYPES = ['Work', 'Personal', 'Health'];
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
  static const TASK_TYPES_COLOR = [
    AppColors.APP_COLOR,
    Colors.orange,
    Colors.lightBlueAccent
  ];
}

class DBKeys {
  static const DATABASE_NAME = "tasks_database.db";

  // ------------ Task table -----------------------

  static const TASKS_TABLE_NAME = "Task";

  static const ID_KEY = "id";
  static const TASK_NAME_KEY = "name";
  static const TASK_DESCRIPTION_KEY = "description";
  static const TASK_PRIORITY_KEY = "priority";
  static const INT_DT = "INTEGER";
  static const TXT_DT = "TEXT";

  // ----------- Firebase keys ----------------------

  static const FIRE_STORE_BASE_TABLE_NAME = "User";
  static const FIRE_sTORE_USER_TABLE_NAME = "Tasks";
}

class UtilityFunctions {
  static resolveTaskTypeToColor(String taskType) {
    for (int i = 0; i < Strings.TASK_TYPES.length; i++)
      if (taskType == Strings.TASK_TYPES[i])
        return AppColors.TASK_TYPES_COLOR[i];
    return AppColors.APP_COLOR;
  }
}
