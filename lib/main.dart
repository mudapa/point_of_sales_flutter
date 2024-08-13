import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cubit/auth_cubit/auth_cubit.dart';
import 'cubit/cart_cubit/cart_cubit.dart';
import 'cubit/cart_cubit/cart_quantity_cubit/cart_quantity_cubit.dart';
import 'cubit/count_cubit/count_cubit.dart';
import 'cubit/product_cubit/product_cubit.dart';
import 'cubit/report_page_cubit/report_page_cubit.dart';
import 'cubit/status_page_cubit/status_page_cubit.dart';
import 'cubit/user_cubit/user_cubit.dart';
import 'firebase_options.dart';
import 'route/route_constans.dart';
import 'route/router.dart' as router;
import 'theme/app_theme.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CountCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => CartQuantityCubit()),
        BlocProvider(create: (context) => StatusPageCubit()),
        BlocProvider(create: (context) => ReportPageCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fin Shop',
            theme: AppTheme.lightTheme(context),
            themeMode: ThemeMode.light,
            onGenerateRoute: router.generateRoute,
            initialRoute: splashPageRoute,
          );
        },
      ),
    );
  }
}
