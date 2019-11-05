import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/models/TaskModel.dart';
import 'package:task_tracker/utilities/Constants.dart';

class TaskCard extends StatelessWidget {
  final TaskViewModel dataModel;
  final Function onDeleteClicked;
  final Function onLongClick;
  final Color taskMainColor;
  TaskCard(
      {this.dataModel,
      this.onDeleteClicked,
      this.onLongClick,
      this.taskMainColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Container(
          height: 100,
          child: Material(
            elevation: 5,
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: taskMainColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          )),
                      width: 5,
                      height: 100,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    dataModel.taskName,
                                    style: TextStyle(
                                      color: taskMainColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(dataModel.taskDescription),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: taskMainColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(dataModel.taskType),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: dataModel.isTaskDone == 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.CLOSED_TASK_COLOR,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        width: 5,
                        height: 100,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: dataModel.isTaskDone == 0,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: taskMainColor,
                      ),
                      onPressed: onDeleteClicked,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
