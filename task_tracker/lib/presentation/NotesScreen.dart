import 'package:flutter/material.dart';
import 'package:task_tracker/utilities/Constants.dart';

import 'utilities_widgets/EmptyListPlaceHolder.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.APP_COLOR,
        title: Text(Strings.ALL_NOTES),
        centerTitle: true,
      ),
      body: EmptyListViewHolder(),
    );
  }
}
