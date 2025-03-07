import 'package:flutter/cupertino.dart';

class ConstStyles {
  ConstStyles._();

  static const padding_10 = EdgeInsets.all(10);
  static const padding_25 = EdgeInsets.all(25);
  static const padding_5 = EdgeInsets.all(5);
  static const space_15 = SizedBox(height: 15);
  static const space_25 = SizedBox(height: 25);
  static const space_10 = SizedBox(height: 10);
  static const space_5 = SizedBox(height: 5);
  static const space_w_5 = SizedBox(width: 5);

  static EdgeInsetsGeometry paddingWeb(double width) =>
      EdgeInsets.all(width * .015);

  static EdgeInsetsGeometry paddingWebLeft(double width) =>
      EdgeInsets.only(left: (width) * .015);

  static EdgeInsetsGeometry paddingWebRight(double width) =>
      EdgeInsets.only(right: (width) * .015);

  static double fontTitle(double width) => width * 0.035;
  static double fontDescription(double width) => width * 0.02;
}
