import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
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
