import 'package:task_tracker/utilities/Constants.dart';

class TaskViewModel {
  var taskName, taskDescription, taskType, taskCreationDate, taskCompletionDate;
  var taskId, isTaskDone;

  TaskViewModel(
      {this.taskDescription,
      this.taskType,
      this.taskName,
      this.taskId,
      this.taskCreationDate,
      this.taskCompletionDate,
      this.isTaskDone});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> taskMap = {
      DBKeys.TASK_NAME_KEY: taskName,
      DBKeys.TASK_PRIORITY_KEY: taskType,
      DBKeys.TASK_DESCRIPTION_KEY: taskDescription,
      DBKeys.TASK_COMPLETION_DATE_KEY: taskCompletionDate,
      DBKeys.TASK_CREATION_DATE_KEY: taskCreationDate,
      DBKeys.TASK_STATUES_KEY: isTaskDone,
    };

    if (taskId != null) taskMap.putIfAbsent(DBKeys.TASK_ID_KEY, () => taskId);

    return taskMap;
  }

  Map<String, dynamic> toCloudMap() {
    return {
      DBKeys.TASK_ID_KEY: taskId.toString(),
      DBKeys.TASK_NAME_KEY: taskName,
      DBKeys.TASK_PRIORITY_KEY: taskType,
      DBKeys.TASK_DESCRIPTION_KEY: taskDescription,
      DBKeys.TASK_COMPLETION_DATE_KEY: taskCompletionDate,
      DBKeys.TASK_CREATION_DATE_KEY: taskCreationDate,
      DBKeys.TASK_STATUES_KEY: isTaskDone,
    };
  }

  static TaskViewModel fromJson(Map<String, dynamic> json) {
    return TaskViewModel(
      taskDescription: json[DBKeys.TASK_DESCRIPTION_KEY] != null
          ? json[DBKeys.TASK_DESCRIPTION_KEY]
          : '',
      taskId: json[DBKeys.TASK_ID_KEY] != null ? json[DBKeys.TASK_ID_KEY] : 0,
      taskType: json[DBKeys.TASK_PRIORITY_KEY] != null
          ? json[DBKeys.TASK_PRIORITY_KEY]
          : '',
      taskName:
          json[DBKeys.TASK_NAME_KEY] != null ? json[DBKeys.TASK_NAME_KEY] : '',
      taskCompletionDate: json[DBKeys.TASK_COMPLETION_DATE_KEY] != null
          ? json[DBKeys.TASK_COMPLETION_DATE_KEY]
          : '',
      taskCreationDate: json[DBKeys.TASK_CREATION_DATE_KEY] != null
          ? json[DBKeys.TASK_CREATION_DATE_KEY]
          : '',
      isTaskDone: json[DBKeys.TASK_STATUES_KEY] != null
          ? json[DBKeys.TASK_STATUES_KEY]
          : 0,
    );
  }
}
