import 'package:flutter/material.dart';

import '../constants.dart';

const AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: whiteColor,
  elevation: 0,
  iconTheme: IconThemeData(color: blackColor),
  titleTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: blackColor,
  ),
);

const AppBarTheme appBarDarkTheme = AppBarTheme(
  backgroundColor: blackColor,
  elevation: 0,
  iconTheme: IconThemeData(color: whiteColor),
  titleTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: whiteColor,
  ),
);

ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
  trackColor: WidgetStateProperty.all(primaryColor),
);
