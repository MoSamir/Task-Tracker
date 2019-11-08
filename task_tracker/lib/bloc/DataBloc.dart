import 'dart:math' as math;
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:task_tracker/models/ChartModel.dart';
import 'package:task_tracker/models/TaskModel.dart';
import 'package:task_tracker/models/UserDataModel.dart';
import 'package:task_tracker/resources/Repository.dart';

class DataBloc extends Bloc<NoteBlocEvents, NoteBlocStates> {
  @override
  // TODO: implement initialState
  NoteBlocStates get initialState => InitialScreen();

  Map<String, ChartModel> createReport() {
    Map<String, ChartModel> statisticalInfo = Map();
    if (state is DataLoaded) {
      (state as DataLoaded).userData.userCategories.forEach((category) {
        statisticalInfo.putIfAbsent(
            category.categoryName,
            () => ChartModel(
                  percentage: 0,
                  deletedTasks: 0,
                  inProgressTasks: 0,
                  segmentColor: Color(int.parse(category.categoryColor)),
                  solvedTasks: 0,
                  segmentLabel: category.categoryName,
                ));
      });
      (state as DataLoaded).userData.userTasks.forEach((task) {
        if (task.isTaskDone == 0) {
          statisticalInfo[task.taskType].inProgressTasks++;
          statisticalInfo[task.taskType].totalCount++;
        } else if (task.isTaskDone == 1) {
          statisticalInfo[task.taskType].solvedTasks++;
          statisticalInfo[task.taskType].totalCount++;
        } else if (task.isTaskDone == 2) {
          statisticalInfo[task.taskType].deletedTasks++;
          statisticalInfo[task.taskType].totalCount++;
        }
      });

      statisticalInfo.forEach((key, value) {
        value.percentage =
            (value.solvedTasks / math.max(value.totalCount, 1) * 1.0);
      });
    }
    return statisticalInfo;
  }

  @override
  Stream<NoteBlocStates> mapEventToState(NoteBlocEvents event) async* {
    if (event is LoadNotes) {
      yield DataLoading();
      try {
        SingleUserDataModel data = await loadUserNotes();
        yield DataLoaded(userData: data);
      } catch (ex) {
        print('Data Loading Error accured  => $ex');
        yield LoadDataError();
      }
    } else if (event is DeleteNote) {
      //yield DataLoading();
      bool deleteStatues = await deleteNote(event.taskViewModel);
      if (deleteStatues) {
        SingleUserDataModel data = await loadUserNotes();
        yield DataLoaded(userData: data);
      } else {
        yield LoadDataError();
      }
    } else if (event is UpdateNote) {
      //yield DataLoading();
      bool updateSuccess = await updateNote(event.taskViewModel);
      if (updateSuccess) {
        SingleUserDataModel data = await loadUserNotes();
        yield DataLoaded(userData: data);
      } else {
        yield LoadDataError();
      }
    } else if (event is CloseNote) {
      //yield DataLoading();
      bool updateSuccess = await closeNote(event.taskViewModel);
      if (updateSuccess) {
        SingleUserDataModel data = await loadUserNotes();
        yield DataLoaded(userData: data);
      } else {
        yield LoadDataError();
      }
    }
  }

  Future<SingleUserDataModel> loadUserNotes() async {
    return (await Repository.loadData());
  }

  Future<bool> deleteNote(TaskViewModel taskViewModel) async {
    return (await Repository.deleteNote(note: taskViewModel));
  }

  Future<bool> updateNote(TaskViewModel taskViewModel) async {
    return (await Repository.updateNote(note: taskViewModel));
  }

  Future<bool> closeNote(TaskViewModel taskViewModel) async {
    return (await Repository.closeNote(note: taskViewModel));
  }
}

// -------------- Data States -----------------

abstract class NoteBlocStates {}

class LoadDataError extends NoteBlocStates {}

class DataLoaded extends NoteBlocStates {
  final SingleUserDataModel userData;
  DataLoaded({this.userData});
}

class DataLoading extends NoteBlocStates {}

class InitialScreen extends NoteBlocStates {}

// ------------ Data Events --------------------

abstract class NoteBlocEvents {}

class LoadNotes extends NoteBlocEvents {}

class DeleteNote extends NoteBlocEvents {
  TaskViewModel taskViewModel;
  DeleteNote(this.taskViewModel);
}

class UpdateNote extends NoteBlocEvents {
  TaskViewModel taskViewModel;
  UpdateNote(this.taskViewModel);
}

class CloseNote extends NoteBlocEvents {
  TaskViewModel taskViewModel;
  CloseNote(this.taskViewModel);
}
