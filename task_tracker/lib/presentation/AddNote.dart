import 'package:flutter/material.dart';
import 'package:task_tracker/presentation/utilities_widgets/LoadingView.dart';
import 'package:task_tracker/utilities/Constants.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.APP_COLOR,
        title: Text(Strings.ADD_TASK),
        centerTitle: true,
      ),
      body: LoadingView(),
    );
  }
}
