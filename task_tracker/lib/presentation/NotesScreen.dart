import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker/bloc/AddNoteBloc.dart';
import 'package:task_tracker/bloc/DataBloc.dart';
import 'package:task_tracker/presentation/utilities_widgets/Appbar.dart';
import 'package:task_tracker/presentation/utilities_widgets/EmptyListPlaceHolder.dart';
import 'package:task_tracker/presentation/utilities_widgets/ErrorView.dart';
import 'package:task_tracker/presentation/utilities_widgets/LoadingView.dart';
import 'package:task_tracker/utilities/Constants.dart';

import 'list_cards/NoteTile.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  DataBloc _bloc;
  ScrollController _controller;

  @override
  void initState() {
    _bloc = BlocProvider.of<DataBloc>(context);
    _controller =
        ScrollController(initialScrollOffset: 0, keepScrollOffset: true);

    if (_bloc.state is DataLoaded == false &&
        _bloc.state is DataLoading == false) _bloc.add(LoadUserData());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    startScroll();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 150,
            child: Container(
              color: Colors.white,
              child: CustomAppbar(
                appBarColor: AppColors.APP_COLOR,
                screenTitle: Strings.ALL_NOTES,
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height - 150,
            child: BlocBuilder(
              bloc: _bloc,
              builder: (context, state) {
                print('Notes screen state $state');
                if (state is DataLoaded) {
                  if (state.userData.userTasks.length == 0)
                    return Container(
                        child: Center(child: EmptyListViewHolder()));
                  else
                    return Container(
                      height: MediaQuery.of(context).size.height - 150,
                      padding: EdgeInsets.only(bottom: 70),
                      color: Colors.white,
                      child: ListView.builder(
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskMainColor: Color(int.parse(
                                UtilityFunctions.resolveTaskTypeToColor(
                                    state.userData.userTasks[index].taskType,
                                    state.userData.userCategories))),
                            dataModel: state.userData.userTasks[index],
                            onDeleteClicked: () {
                              _bloc.add(
                                  DeleteNote(state.userData.userTasks[index]));
                            },
                            onLongClick: state
                                        .userData.userTasks[index].isTaskDone ==
                                    0
                                ? () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                Text(Strings.CLOSE_TASK_TITLE),
                                            actions: <Widget>[
                                              RaisedButton(
                                                color: AppColors.APP_COLOR,
                                                child: Text(
                                                  Strings.CLOSE_BUTTON_LABEL,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.WHITE_COLOR,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  state
                                                      .userData
                                                      .userTasks[index]
                                                      .isTaskDone = 1;
                                                  _bloc.add(CloseNote(state
                                                      .userData
                                                      .userTasks[index]));
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                : null,
                          );
                        },
                        itemCount: state.userData.userTasks.length,
                      ),
                    );
                } else if (state is FailedState || state is LoadDataError) {
                  return ErrorHandleView();
                } else
                  return LoadingView();
              },
            ),
          ),
        ],
      ),
      //EmptyListViewHolder(),
    );
  }

  void startScroll() {
    Future.delayed(Duration(seconds: 1), () {
      if (_controller.hasClients)
        _controller.animateTo(_controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    });
  }
}
