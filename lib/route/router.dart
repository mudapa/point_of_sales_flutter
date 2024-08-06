import 'package:flutter/material.dart';

import 'screen_export.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashPageRoute:
      return MaterialPageRoute(builder: (context) => const SplashPage());
    default:
      return MaterialPageRoute(builder: (context) => const SplashPage());
  }
}
