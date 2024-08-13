import 'package:flutter/material.dart';

import 'screen_export.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashPageRoute:
      return MaterialPageRoute(builder: (context) => const SplashPage());
    case onboardingPageRoute:
      return MaterialPageRoute(builder: (context) => const OnboardingPage());
    case loginPageRoute:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case entryPointPageRoute:
      return MaterialPageRoute(builder: (context) => const EntryPoint());
    case homePageRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case discoverPageRoute:
      return MaterialPageRoute(builder: (context) => const DiscoverPage());
    case cartPageRoute:
      return MaterialPageRoute(builder: (context) => const CartPage());
    case profilePageRoute:
      return MaterialPageRoute(builder: (context) => const ProfilePage());
    case searchPageRoute:
      return MaterialPageRoute(builder: (context) => const SearchPage());
    case paymentPageRoute:
      return MaterialPageRoute(builder: (context) => const PaymentPage());
    case statusPageRoute:
      return MaterialPageRoute(builder: (context) => const StatusPage());
    case reportPageRoute:
      return MaterialPageRoute(builder: (context) => const ReportPage());
    default:
      return MaterialPageRoute(builder: (context) => const SplashPage());
  }
}
