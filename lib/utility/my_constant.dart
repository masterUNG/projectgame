import 'package:flutter/material.dart';

class MyConstant {
  static String routeHome = '/home';
  static String routePagemenu = '/pagemenu';
  static String routeIntroBird = '/introbird';
  static String routeCountTime = '/counttime';
  static String routeGameBird = '/gamebird';
  static String routeResultBird = '/resultbird';

  static Color primary = Colors.green;
  static Color dart = Colors.indigo;
  static Color light = Colors.yellow;

  TextStyle h0Style() => TextStyle(
        color: dart,
        fontSize: 90,
        fontWeight: FontWeight.bold,
      );

TextStyle h1Style() => TextStyle(
        color: dart,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        color: dart,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        color: dart,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
}
