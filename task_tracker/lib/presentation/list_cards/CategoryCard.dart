import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:task_tracker/models/CategoryModel.dart';
import 'package:task_tracker/utilities/Constants.dart';

class CategoryCard extends StatelessWidget {
  final CategoryViewModel categoryViewModel;
  final int associatedTasks;
  final Function addCategoryAction;
  Color textColor = AppColors.BLACK_COLOR;
  CategoryCard(
      {this.categoryViewModel, this.associatedTasks, this.addCategoryAction});

  @override
  Widget build(BuildContext context) {
    Color mainColor = categoryViewModel != null
        ? Color(int.parse(categoryViewModel.categoryColor))
        : Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0);

    textColor = UtilityFunctions.isDarkColor(mainColor)
        ? AppColors.WHITE_COLOR
        : AppColors.BLACK_COLOR;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          type: MaterialType.card,
          elevation: 2,
          borderRadius: BorderRadius.circular(10),
          color: mainColor,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 900),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [mainColor, Colors.white]),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: (categoryViewModel == null)
                    ? buildAddCategoryCard()
                    : buildCategoryCard()),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          categoryViewModel.categoryName,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$associatedTasks',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildAddCategoryCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: AppColors.WHITE_COLOR,
            size: 30,
          ),
          onPressed: addCategoryAction,
        ),
        Text(
          'New Category',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
