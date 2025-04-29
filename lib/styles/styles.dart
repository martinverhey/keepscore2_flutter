import 'package:flutter/material.dart';

class AppStyle {
  AppColors colors = AppColors();
  Insets insets = Insets();
  Corners corners = Corners();
  TextStyles text = TextStyles();
}

class AppColors {
  Color black = Colors.black;
  Color white = Colors.white;
  Color red = Colors.red;
  Color orange = Colors.orange;
  Color deepOrange = Colors.deepOrange;
  Color blue = Colors.blue;
  Color green = Colors.green;
  Color grey = Colors.grey;
  Color grey100 = Colors.grey.shade100;
  Color grey200 = Colors.grey.shade200;
  Color grey500 = Colors.grey.shade500;
}

class TextStyles {
  TextStyle get h1 => const TextStyle(fontSize: 28);
  TextStyle get h2 => const TextStyle(fontSize: 24);
  TextStyle get h3 => const TextStyle(fontSize: 20);
  TextStyle get body => const TextStyle(fontSize: 16);
  TextStyle get subtitle => const TextStyle(fontSize: 12);
}

class Insets {
  final double xxs = 1;
  final double xs = 2;
  final double s = 4;
  final double m = 8;
  final double l = 16;
  final double xl = 32;
}

class Corners {
  final double s = 4;
  final double m = 8;
  final double l = 16;
}
