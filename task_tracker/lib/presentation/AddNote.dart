import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:task_tracker/bloc/AddNoteBloc.dart';
import 'package:task_tracker/bloc/DataBloc.dart';
import 'package:task_tracker/models/TaskModel.dart';
import 'package:task_tracker/presentation/BarRootScreen.dart';
import 'package:task_tracker/presentation/utilities_widgets/ErrorView.dart';
import 'package:task_tracker/presentation/utilities_widgets/LoadingView.dart';
import 'package:task_tracker/utilities/Constants.dart';
import 'package:toast/toast.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  Color taskColor = AppColors.APP_COLOR;
  TaskViewModel taskViewModel = TaskViewModel();
  DataBloc dataBloc;
  bool categoryDefined = false;
  AddNoteBloc _bloc;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    dataBloc = BlocProvider.of<DataBloc>(context);
    _bloc = AddNoteBloc();
    dataBloc.listen((state) {
      if (state is DataLoaded)
        setState(() {
          taskViewModel.taskType =
              state.userData.userCategories[0].categoryName;
        });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (dataBloc.state is DataLoaded) {
      ((dataBloc.state as DataLoaded))
          .userData
          .userCategories
          .forEach((category) {
        print('Category =>  ${category.categoryColor}');
      });
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: taskColor,
          title: Text(Strings.ADD_TASK),
          centerTitle: true,
        ),
        body: BlocListener(
          bloc: _bloc,
          listener: (context, state) {
            if (state is SuccessState) {
              Toast.show(Strings.SAVE_TASK_SUCCESS_MESSAGE, context,
                  duration: 5, gravity: Toast.BOTTOM);
              BlocProvider.of<DataBloc>(context).add(LoadNotes());
              _taskNameController.clear();
              _taskDescriptionController.clear();
              RootScreen.navigatorKey.currentState.setPage(2);
            } else if (state is FailedState) {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => AlertDialog(
                  elevation: 2,
                  title: Text(Strings.SAVE_TASK_FAILED_MESSAGE),
                  content: ErrorHandleView(),
                ),
              );
            }
          },
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state is NoteLoading,
                progressIndicator: LoadingView(),
                child: SingleChildScrollView(
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 2,
                              type: MaterialType.card,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: taskColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                    ),
                                    width: 10,
                                    height: 50,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (text) {
                                        return (text.length > 0)
                                            ? null
                                            : Strings.REQUIRED_FIELD_ERROR;
                                      },
                                      controller: _taskNameController,
                                      onChanged: (text) {
                                        if (categoryDefined == false)
                                          suggestCategory(text);
                                      },
                                      cursorColor: taskColor,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: Strings.TASK_NAME_HINT,
                                        hintStyle: TextStyle(
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              Strings.TASK_CATEGORY_LABEL,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          (dataBloc.state is DataLoaded)
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: (dataBloc.state as DataLoaded)
                                      .userData
                                      .userCategories
                                      .length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      isThreeLine: false,
                                      dense: true,
                                      title: Text((dataBloc.state as DataLoaded)
                                          .userData
                                          .userCategories[index]
                                          .categoryName),
                                      onChanged: (v) {
                                        setState(() {
                                          categoryDefined = true;
                                          taskColor = Color(int.parse(
                                              (dataBloc.state as DataLoaded)
                                                  .userData
                                                  .userCategories[index]
                                                  .categoryColor));
                                          taskViewModel.taskType =
                                              (dataBloc.state as DataLoaded)
                                                  .userData
                                                  .userCategories[index]
                                                  .categoryName;
                                        });
                                      },
                                      selected: (dataBloc.state as DataLoaded)
                                              .userData
                                              .userCategories[index]
                                              .categoryName ==
                                          taskViewModel.taskType,
                                      value: taskViewModel.taskType,
                                      activeColor: Color(int.parse(
                                          (dataBloc.state as DataLoaded)
                                              .userData
                                              .userCategories[index]
                                              .categoryColor)),
                                      groupValue: (dataBloc.state as DataLoaded)
                                          .userData
                                          .userCategories[index]
                                          .categoryName,
                                    );
                                  },
                                )
                              : SizedBox(
                                  child: LoadingView(),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              Strings.TASK_DESCRIPTION_LABEL,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Material(
                                borderRadius: BorderRadius.circular(5),
                                elevation: 2,
                                type: MaterialType.card,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: taskColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                        ),
                                      ),
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        maxLines: 5,
                                        controller: _taskDescriptionController,
                                        cursorColor: taskColor,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              Strings.TASK_DESCRIPTION_HINT,
                                          hintStyle: TextStyle(
                                            color: Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: RaisedButton(
                              onPressed: () => createNote(),
                              elevation: 5,
                              color: taskColor,
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  Strings.SAVE_TASK_BUTTON_TEXT,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
        //LoadingView(),
        );
  }

  @override
  void dispose() {
    _bloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  void createNote() {
    if (_formKey.currentState.validate()) {
      taskViewModel.taskDescription = _taskDescriptionController.text.length > 0
          ? _taskDescriptionController.text
          : '';
      taskViewModel.taskName = _taskNameController.text;
      //(note:taskViewModel);
      _bloc.add(CreateNote(newNote: taskViewModel));
    }
  }

  void suggestCategory(String text) {
    if (dataBloc.state is DataLoaded) {
      (dataBloc.state as DataLoaded).userData.userCategories.forEach(
        (category) {
          if (category.categoryName
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase())) {
            setState(() {
              //categoryDefined = true;
              taskColor = Color(int.parse(category.categoryColor));
              taskViewModel.taskType = category.categoryName;
              return;
            });
          }
        },
      );

//      setState(() {
//        //categoryDefined = true;
//        taskColor = Color(int.parse((dataBloc.state as DataLoaded)
//            .userData
//            .userCategories[0]
//            .categoryColor));
//        taskViewModel.taskType = (dataBloc.state as DataLoaded)
//            .userData
//            .userCategories[0]
//            .categoryName;
//        return;
//      });
    }
  }
}
