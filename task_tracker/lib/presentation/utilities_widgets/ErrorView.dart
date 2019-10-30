import 'package:flutter/material.dart';
import 'package:task_tracker/utilities/Constants.dart';

class ErrorHandleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: AppColors.WHITE_COLOR,
      child: Center(
        child: Image.asset(
          Assets.NOT_FOUND,
          width: width * .5,
          height: height * .5,
        ),
      ),
    );
  }
}
