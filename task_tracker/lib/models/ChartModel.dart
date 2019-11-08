import 'dart:ui';

class ChartModel {
  Color segmentColor;
  double percentage;
  String segmentLabel;
  int solvedTasks, deletedTasks, inProgressTasks, totalCount = 0;
  ChartModel({
    this.segmentColor,
    this.percentage,
    this.segmentLabel,
    this.solvedTasks,
    this.deletedTasks,
    this.inProgressTasks,
  });
}
