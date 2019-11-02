import 'package:flutter/material.dart';
import 'package:task_tracker/presentation/utilities_widgets/ErrorView.dart';
import 'package:task_tracker/utilities/Constants.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.APP_COLOR,
        title: Text(Strings.HOME),
        centerTitle: true,
      ),
      body: ErrorHandleView(),
    );
  }
}
