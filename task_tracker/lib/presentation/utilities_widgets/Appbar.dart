import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_tracker/utilities/Constants.dart';
import 'package:task_tracker/utilities/Painters.dart';

class CustomAppbar extends StatefulWidget {
  final String screenTitle;
  final Color appBarColor;
  final List<Widget> actions;
  final Widget leading;
  final animate = false;

  CustomAppbar(
      {this.screenTitle, this.appBarColor, this.actions, this.leading});
  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  String screenTitle;
  Color appBarColor;
  List<Widget> actions;
  double TITLE_RADIUS = Constants.AVATAR_RADIUS,
      AppBarHeight = Constants.CURVE_HEIGHT;
  Widget leading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Constants.ANIMATION_ENABLED) {
      TITLE_RADIUS = 0;
      AppBarHeight = 0;
      Future.delayed(Duration(milliseconds: 1), () => buildAppbar(context));
      Future.delayed(Duration(seconds: 1), () => buildTitle(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    appBarColor = widget.appBarColor;
    screenTitle = widget.screenTitle;
    leading = widget.leading;

    print('Leading is null ? ${leading == null}');
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              height: AppBarHeight,
              duration: Duration(seconds: 2),
              color: Colors.transparent,
              child: Container(
                width: double.infinity,
                height: Constants.CURVE_HEIGHT,
                child: CustomPaint(
                  painter: CubicCurvePainter(
                    toolBarColor: appBarColor,
                  ),
                ),
              ),
            ),
            Positioned(
              top: Constants.CURVE_HEIGHT * .21,
              right: MediaQuery.of(context).size.width * .37,
              child: Material(
                shadowColor: Colors.black12,
                elevation: 10,
                borderRadius: BorderRadius.circular(Constants.AVATAR_RADIUS),
                color: Colors.transparent,
                child: AnimatedContainer(
                  height: TITLE_RADIUS * 1.8,
                  duration: Duration(seconds: 1),
                  child: CircleAvatar(
                    backgroundColor: AppColors.GREY_200_COLOR,
                    radius: Constants.AVATAR_RADIUS,
                    child: Center(
                        child: AutoSizeText(
                      screenTitle,
                      textAlign: TextAlign.center,
                      maxFontSize: 18,
                      minFontSize: 8,
                    )),
                  ),
                ),
              ),
            ),
            leading != null
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: SizedBox(
//                        height: 50,
//                        width: 50,
                        child: leading,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  buildTitle(BuildContext context) {
    TITLE_RADIUS = Constants.AVATAR_RADIUS;
    if (mounted) setState(() {});
  }

  buildAppbar(BuildContext context) {
    AppBarHeight = Constants.CURVE_HEIGHT;
    if (mounted) setState(() {});
  }
}
