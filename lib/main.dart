import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ketkray_garden/presentation/pages/start_page.dart';
import 'package:ketkray_garden/routing/route_generator.dart';
import 'package:ketkray_garden/utils/custom_behavior.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  setPathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        builder: EasyLoading.init(),
        title: 'Ketkray Garder',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          fontFamily: 'NotoSansThai',
        ),
        debugShowCheckedModeBanner: false,
        scrollBehavior: CustomScrollBehavior(),
        home: const StartPage(),
        onGenerateRoute: generateRoute,
        initialRoute: StartPage.routeName,
      );
    });
  }
}
