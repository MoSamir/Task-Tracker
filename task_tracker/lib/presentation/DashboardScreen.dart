import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:task_tracker/bloc/DataBloc.dart';
import 'package:task_tracker/presentation/list_cards/ChartCard.dart';
import 'package:task_tracker/presentation/utilities_widgets/Appbar.dart';
import 'package:task_tracker/presentation/utilities_widgets/LoadingView.dart';
import 'package:task_tracker/utilities/Constants.dart';
import 'package:toast/toast.dart';

import 'AddCategory.dart';
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

    if (bloc.state is DataLoaded == false &&
        bloc.state is DataLoading == false) {
      bloc.add(LoadUserData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is DataLoaded) {
            return SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  child: CustomAppbar(
                    appBarColor: AppColors.APP_COLOR,
                    screenTitle: Strings.HOME,
                  ),
                ),
                statisticWidget(),
                categoriesGrid(),
                SizedBox(
                  height: 50,
                ),
              ],
            ));
          } else
            return Container(
              child: Center(child: LoadingView()),
            );
        },
      ),
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
                Toast.show("warning -- Initial Draft", context,
                    duration: 5, gravity: Toast.BOTTOM);

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddCategory(
                    dataBloc: bloc,
                  );
                }));
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
