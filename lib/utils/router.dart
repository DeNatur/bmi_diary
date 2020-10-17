import 'package:bmi_diary/calculator/calculator_page.dart';
import 'package:bmi_diary/diary/diary_page.dart';
import 'package:bmi_diary/result/result_page.dart';
import 'package:bmi_diary/utils/constants/route_names.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case CalculatorViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CalculatorPage(),
      );
    case ResultViewRoute:
      return _getPageRouteWithArgs(
          routeName: settings.name,
          viewToShow: ResultPage(),
          arguments: settings.arguments);
    case DiaryViewRoute:
      return _getPageRouteWithArgs(
          routeName: settings.name,
          viewToShow: DiaryPage(),
          arguments: settings.arguments);
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}

PageRoute _getPageRouteWithArgs(
    {String routeName, Widget viewToShow, dynamic arguments}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: routeName, arguments: arguments),
      builder: (_) => viewToShow);
}
