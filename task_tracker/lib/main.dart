import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker/bloc/DataBloc.dart';
import 'package:task_tracker/presentation/BarRootScreen.dart';
import 'package:task_tracker/resources/database_provider/DatabaseProvider.dart';
import 'package:task_tracker/resources/firebase_provider/FirebaseProvider.dart';
import 'package:task_tracker/utilities/NotificationController.dart';

void main() async {
  NotificationController.initOneSignal();
  NotificationController.initLocalNotification();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  DataBloc dataBloc = DataBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    DatabaseProvider.createDb(bloc: dataBloc);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.suspending) {
      if (dataBloc.state is DataLoaded) {
        print('Backup initialzed ');
        BackupController.backupDB(
            (dataBloc.state as DataLoaded).userData.userTasks);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Tracker',
      home: BlocProvider<DataBloc>.value(
        child: RootScreen(),
        value: dataBloc,
      ),
    );
  }
}
