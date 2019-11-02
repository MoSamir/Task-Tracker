import 'package:task_tracker/models/TaskModel.dart';
import 'package:bloc/bloc.dart';
import 'package:task_tracker/resources/Repository.dart';

class DataBloc extends Bloc<NoteBlocEvents, NoteBlocStates> {
  @override
  // TODO: implement initialState
  NoteBlocStates get initialState => InitialScreen();

  @override
  Stream<NoteBlocStates> mapEventToState(NoteBlocEvents event) async* {
    if (event is LoadNotes) {
      yield DataLoading();
      try {
        List<TaskViewModel> data = await loadUserNotes();
        yield DataLoaded(userNotes: data);
      } catch (ex) {
        print('Data Loading Error accured  => $ex');
        yield LoadDataError();
      }
    } else if (event is DeleteNote) {
      //yield DataLoading();
      bool deleteStatues = await deleteNote(event.taskViewModel);
      if (deleteStatues) {
        List<TaskViewModel> data = await loadUserNotes();
        yield DataLoaded(userNotes: data);
      } else {
        yield LoadDataError();
      }
    }
  }

  Future<List<TaskViewModel>> loadUserNotes() async {
    return (await Repository.loadData());
  }

  Future<bool> deleteNote(TaskViewModel taskViewModel) async {
    return (await Repository.deleteNote(note: taskViewModel));
  }
}

// -------------- Data States -----------------

abstract class NoteBlocStates {}

class LoadDataError extends NoteBlocStates {}

class DataLoaded extends NoteBlocStates {
  final List<TaskViewModel> userNotes;
  DataLoaded({this.userNotes});
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
