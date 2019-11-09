import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task_tracker/utilities/Constants.dart';

class LoadingView extends StatefulWidget {
  final Color indicatorColor;
  LoadingView({this.indicatorColor});

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with TickerProviderStateMixin {
  var spinnerKit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          height: 50,
          child: spinnerKit = SpinKitThreeBounce(
            color: widget.indicatorColor ?? AppColors.APP_COLOR,
            size: 25.0,
            controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 1200)),
          ),
        ),
      ),
    );
  }
}
