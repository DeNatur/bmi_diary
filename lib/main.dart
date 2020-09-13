import 'package:bmi_diary/calculator/calculator_page.dart';
import 'package:bmi_diary/database/database.dart';
import 'package:bmi_diary/services/navigation_service.dart';
import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:bmi_diary/utils/localedelegate.dart';
import 'package:bmi_diary/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(
      () => DatabaseManager(databaseProvider: DatabaseProvider.get));
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return NeumorphicApp(
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: color_bg,
        intensity: 0.3,
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      title: 'BMI Diary',
      localizationsDelegates: [
        const LocDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('pl', ''), // Polish, no country code
      ],
      navigatorKey: locator<NavigationService>().navigationKey,
      home: CalculatorPage(),
      onGenerateRoute: generateRoute,
    );
  }
}
