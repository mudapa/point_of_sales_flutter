import 'package:flutter/material.dart';

import '../constants.dart';
import 'font_theme.dart';

AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: whiteColor,
  elevation: 0,
  iconTheme: const IconThemeData(color: blackColor),
  titleTextStyle: regulerText.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: blackColor,
  ),
);

AppBarTheme appBarDarkTheme = AppBarTheme(
  backgroundColor: blackColor,
  elevation: 0,
  iconTheme: const IconThemeData(color: whiteColor),
  titleTextStyle: regulerText.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: whiteColor,
  ),
);

ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
  trackColor: WidgetStateProperty.all(primaryColor),
);
