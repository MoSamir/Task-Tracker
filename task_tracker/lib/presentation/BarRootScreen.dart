import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/presentation/AddNote.dart';
import 'package:task_tracker/presentation/DashboardScreen.dart';
import 'package:task_tracker/utilities/Constants.dart';
import 'NotesScreen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FancyBottomNavigation(
        activeIconColor: AppColors.WHITE_COLOR,
        barBackgroundColor: AppColors.WHITE_COLOR,
        inactiveIconColor: AppColors.BLACK_COLOR,
        initialSelection: 1,
        circleColor: AppColors.APP_COLOR,
        tabs: [
          TabData(iconData: Icons.dashboard, title: Strings.HOME),
          TabData(iconData: Icons.add_circle_outline, title: Strings.ADD_TASK),
          TabData(iconData: Icons.event_note, title: Strings.ALL_NOTES)
        ],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
      body: getScreenBody(),
    );
  }

  getScreenBody() {
    print('Current Page => $currentPage');

    if (currentPage == 0) {
      return DashboardScreen();
    } else if (currentPage == 1) {
      return AddNoteScreen();
    } else if (currentPage == 2) {
      return NotesScreen();
    } else {
      return Container(
        child: Center(child: Image.asset(Assets.NOT_FOUND)),
      );
    }
  }
}
