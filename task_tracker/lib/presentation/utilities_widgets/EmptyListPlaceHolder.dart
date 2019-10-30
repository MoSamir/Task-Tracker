import 'package:flutter/material.dart';
import 'package:task_tracker/utilities/Constants.dart';

class EmptyListViewHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: AppColors.WHITE_COLOR,
      child: Center(
        child: Image.asset(
          Assets.NO_ITEMS_PLACEHOLDER,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
