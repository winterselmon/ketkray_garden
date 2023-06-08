import 'package:flutter/material.dart';

Widget addVerticalSpace(double height, {double ratio = 1.0}) {
  return SizedBox(height: height * ratio);
}

Widget addHorizontalSpace(double width, {double ratio = 1.0}) {
  return SizedBox(width: width * ratio);
}

EdgeInsets symmetricVertical(double height, {double ratio = 1.0}) {
  return EdgeInsets.symmetric(vertical: height * ratio);
}

EdgeInsets symmetricHorizontal(double width, {double ratio = 1.0}) {
  return EdgeInsets.symmetric(horizontal: width * ratio);
}

int expandFlex(int? flex) => flex ?? 1;

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

bool screenIsPortrait(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.portrait;
