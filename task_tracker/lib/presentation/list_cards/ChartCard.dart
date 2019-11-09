import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:task_tracker/models/ChartModel.dart';
import 'package:task_tracker/utilities/Constants.dart';

class StatisticsChart extends StatelessWidget {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final ChartModel chartModel;
  StatisticsChart({this.chartModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        shadowColor: Colors.black12,
        animationDuration: Duration(seconds: 2),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              style: BorderStyle.solid,
              color: chartModel.segmentColor,
              width: 2,
            )),
        type: MaterialType.card,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [chartModel.segmentColor, Colors.black12]),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  chartModel.segmentLabel,
                  style: TextStyle(
                    color: AppColors.WHITE_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AnimatedCircularChart(
                    key: _chartKey,
                    holeLabel: chartModel.totalCount == 0
                        ? '100 %'
                        : '${(chartModel.percentage * 100).toStringAsFixed(2)} %',
                    labelStyle: TextStyle(
                      color: chartModel.segmentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                    duration: Duration(seconds: 2),
                    size: const Size(120.0, 120.0),
                    initialChartData: <CircularStackEntry>[
                      new CircularStackEntry(
                        chartInfo(),
                        rankKey: 'progress',
                      ),
                    ],
                    chartType: CircularChartType.Radial,
                    edgeStyle: SegmentEdgeStyle.round,
                    percentageValues: true,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "In progress",
                            style: TextStyle(
                              color: AppColors.WHITE_COLOR,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${chartModel.inProgressTasks}',
                            style: TextStyle(
                              color: AppColors.WHITE_COLOR,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.black12,
                        height: 20,
                        width: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Solved",
                            style: TextStyle(
                              color: AppColors.WHITE_COLOR,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${chartModel.solvedTasks}',
                            style: TextStyle(
                              color: AppColors.WHITE_COLOR,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.black12,
                        height: 20,
                        width: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Archived",
                            style: TextStyle(
                              color: AppColors.WHITE_COLOR,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${chartModel.deletedTasks}',
                            style: TextStyle(
                              color: AppColors.WHITE_COLOR,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<CircularSegmentEntry> chartInfo() {
    List<CircularSegmentEntry> info = [];
    info.add(CircularSegmentEntry(
      chartModel.percentage * 100,
      chartModel.segmentColor,
      rankKey: 'progress',
    ));
    info.add(CircularSegmentEntry(
      (100 - (chartModel.percentage * 100)),
      AppColors.WHITE_COLOR,
      rankKey: 'missing',
    ));
    return info;
  }
}
