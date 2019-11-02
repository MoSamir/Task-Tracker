import 'package:task_tracker/utilities/Constants.dart';

class TaskViewModel {
  String taskName, taskDescription, taskType;
  int taskId;

  TaskViewModel(
      {this.taskDescription, this.taskType, this.taskName, this.taskId});

  Map<String, dynamic> toMap() {
    return {
      //DBKeys.ID_KEY: taskId.toString(),
      DBKeys.TASK_NAME_KEY: taskName,
      DBKeys.TASK_PRIORITY_KEY: taskType,
      DBKeys.TASK_DESCRIPTION_KEY: taskDescription,
    };
  }

  Map<String, dynamic> toCloudMap() {
    return {
      DBKeys.ID_KEY: taskId.toString(),
      DBKeys.TASK_NAME_KEY: taskName,
      DBKeys.TASK_PRIORITY_KEY: taskType,
      DBKeys.TASK_DESCRIPTION_KEY: taskDescription,
    };
  }

  static TaskViewModel fromJson(Map<String, dynamic> json) {
    return TaskViewModel(
      taskDescription: json[DBKeys.TASK_DESCRIPTION_KEY] != null
          ? json[DBKeys.TASK_DESCRIPTION_KEY]
          : '',
      taskId: json[DBKeys.ID_KEY] != null ? json[DBKeys.ID_KEY] : 0,
      taskType: json[DBKeys.TASK_PRIORITY_KEY] != null
          ? json[DBKeys.TASK_PRIORITY_KEY]
          : '',
      taskName:
          json[DBKeys.TASK_NAME_KEY] != null ? json[DBKeys.TASK_NAME_KEY] : '',
    );
  }
}
