import 'package:task_tracker/models/CategoryModel.dart';
import 'package:task_tracker/models/TaskModel.dart';

class SingleUserDataModel {
  List<CategoryViewModel> userCategories;
  List<TaskViewModel> userTasks;
  SingleUserDataModel({this.userCategories, this.userTasks});
}
