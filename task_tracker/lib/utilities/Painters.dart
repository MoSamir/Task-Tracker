import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

class CubicCurvePainter extends CustomPainter {
  Color toolBarColor;
  CubicCurvePainter({this.toolBarColor});

  @override
  void paint(Canvas canvas, Size size) {
    // print('Hello Painter $toolBarColor');

    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = toolBarColor;

    Offset shapeBegin = Offset(0, 0);

    Offset curveBegin = Offset(0, size.height * .4);

    Offset shapeCenter = Offset(size.width * .5, size.height);
    Offset shapeEnd = Offset(size.width, 0);

    Path path = Path()
      ..moveTo(shapeBegin.dx, shapeBegin.dy)
      ..lineTo(curveBegin.dx, curveBegin.dy + 10)
      ..cubicTo(shapeBegin.dx, shapeBegin.dy, shapeCenter.dx, shapeCenter.dy,
          shapeEnd.dx, shapeEnd.dy + 50)
      ..lineTo(shapeEnd.dx, shapeEnd.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = Colors.purple[700];

    Offset circleCenter =
        Offset(size.width / 2, size.height - Constants.AVATAR_RADIUS);
    Offset topLeft = Offset(0, 0);
    Offset bottomLeft = Offset(0, size.height * 0.25);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height * 0.5);

    Offset leftCurveControlPoint = Offset(
        circleCenter.dx * 0.5, size.height - Constants.AVATAR_RADIUS * 1.5);
    Offset rightCurveControlPoint =
        Offset(circleCenter.dx * 1.6, size.height - Constants.AVATAR_RADIUS);

    final arcStartAngle = 200 / 180 * math.pi;
    final avatarLeftPointX =
        circleCenter.dx + Constants.AVATAR_RADIUS * math.cos(arcStartAngle);

    final avatarLeftPointY =
        circleCenter.dy + Constants.AVATAR_RADIUS * math.sin(arcStartAngle);

    Offset avatarLeftPoint =
        Offset(avatarLeftPointX, avatarLeftPointY); // the left point of the arc

    final arcEndAngle = -5 / 180 * math.pi;

    final avatarRightPointX =
        circleCenter.dx + Constants.AVATAR_RADIUS * math.cos(arcEndAngle);

    final avatarRightPointY =
        circleCenter.dy + Constants.AVATAR_RADIUS * math.sin(arcEndAngle);
    Offset avatarRightPoint = Offset(
        avatarRightPointX, avatarRightPointY); // the right point of the arc

    Path path = Path()
      ..moveTo(topLeft.dx,
          topLeft.dy) // this move isn't required since the start point is (0,0)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(leftCurveControlPoint.dx, leftCurveControlPoint.dy,
          avatarLeftPoint.dx, avatarLeftPoint.dy)
      ..arcToPoint(avatarRightPoint,
          radius: Radius.circular(Constants.AVATAR_RADIUS))
      ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy,
          bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
