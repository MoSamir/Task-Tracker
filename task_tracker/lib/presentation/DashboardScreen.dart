import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:task_tracker/bloc/DataBloc.dart';
import 'package:task_tracker/presentation/list_cards/ChartCard.dart';
import 'package:task_tracker/utilities/Constants.dart';
import 'package:toast/toast.dart';

import 'list_cards/CategoryCard.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DataBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<DataBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.APP_COLOR,
        title: Text(Strings.HOME),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          statisticWidget(),
          categoriesGrid(),
          SizedBox(
            height: 50,
          ),
        ],
      )),
      // ErrorHandleView(),
    );
  }

  Widget statisticWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * .35,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: MediaQuery.of(context).size.width * .95,
        itemCount: (bloc.state as DataLoaded).userData.userCategories.length,
        controller: SwiperController(),
        itemBuilder: (context, index) {
          return StatisticsChart(
            chartModel:
                bloc.createReport()[bloc.createReport().keys.toList()[index]],
          );
        },
      ),
    );
  }

  Widget categoriesGrid() {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount:
            (bloc.state as DataLoaded).userData.userCategories.length + 1,
        itemBuilder: (context, index) {
          if (index ==
              (bloc.state as DataLoaded).userData.userCategories.length) {
            return CategoryCard(
              addCategoryAction: () {
                Toast.show("Comming Soon", context,
                    duration: 5, gravity: Toast.BOTTOM);
              },
            );
          } else
            return CategoryCard(
              categoryViewModel:
                  (bloc.state as DataLoaded).userData.userCategories[index],
              associatedTasks: bloc
                  .createReport()[(bloc.state as DataLoaded)
                      .userData
                      .userCategories[index]
                      .categoryName]
                  .totalCount,
            );
        });
  }
}
