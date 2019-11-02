import 'package:task_tracker/models/TaskModel.dart';
import 'package:bloc/bloc.dart';
import 'package:task_tracker/resources/Repository.dart';

class AddNoteBloc extends Bloc<AddNoteEvents, AddNoteStates> {
  @override
  // TODO: implement initialState
  AddNoteStates get initialState => InitialScreenState();

  @override
  Stream<AddNoteStates> mapEventToState(AddNoteEvents event) async* {
    if (event is CreateNote) {
      yield NoteLoading();
      try {
        bool noteAdded = await Repository.addNote(note: event.newNote);

        await Future.delayed(Duration(seconds: 5));
        yield noteAdded ? SuccessState() : FailedState();
      } catch (ex) {
        yield FailedState();
      }
    }
  }
}

abstract class AddNoteEvents {}

class CreateNote extends AddNoteEvents {
  final TaskViewModel newNote;
  CreateNote({this.newNote});
}

abstract class AddNoteStates {}

class InitialScreenState extends AddNoteStates {}

class NoteLoading extends AddNoteStates {}

class SuccessState extends AddNoteStates {}

class FailedState extends AddNoteStates {}
