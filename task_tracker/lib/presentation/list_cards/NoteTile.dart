import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/models/TaskModel.dart';
import 'package:task_tracker/utilities/Constants.dart';

class TaskCard extends StatelessWidget {
  final TaskViewModel dataModel;
  final Function onDeleteClicked;
  TaskCard({this.dataModel, this.onDeleteClicked});

  @override
  Widget build(BuildContext context) {
    Color mainColor =
        UtilityFunctions.resolveTaskTypeToColor(dataModel.taskType);

    return Padding(
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
                        color: mainColor,
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
                                    color: mainColor,
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
                                    color: mainColor,
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
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: mainColor,
                  ),
                  onPressed: onDeleteClicked,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
