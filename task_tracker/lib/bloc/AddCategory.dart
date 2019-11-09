import 'package:bloc/bloc.dart';
import 'package:task_tracker/models/CategoryModel.dart';
import 'package:task_tracker/resources/Repository.dart';

class AddCategoryBloc extends Bloc<AddCategoryBlocEvents, AddCategoryStates> {
  @override
  // TODO: implement initialState
  AddCategoryStates get initialState => InitialScreenState();

  @override
  Stream<AddCategoryStates> mapEventToState(
      AddCategoryBlocEvents event) async* {
    if (event is CreateCategory) {
      yield CategoryLoading();
      try {
        bool noteAdded =
            await Repository.addCategory(category: event.newCategory);

        await Future.delayed(Duration(seconds: 5));
        yield noteAdded ? SuccessState() : FailedState();
      } catch (ex) {
        yield FailedState();
      }
    }
  }
}

abstract class AddCategoryBlocEvents {}

class CreateCategory extends AddCategoryBlocEvents {
  final CategoryViewModel newCategory;
  CreateCategory({this.newCategory});
}

abstract class AddCategoryStates {}

class InitialScreenState extends AddCategoryStates {}

class CategoryLoading extends AddCategoryStates {}

class SuccessState extends AddCategoryStates {}

class FailedState extends AddCategoryStates {}
