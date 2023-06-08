import 'package:flutter/material.dart';
import 'package:ketkray_garden/presentation/pages/manage_page.dart';
import 'package:ketkray_garden/presentation/pages/start_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // final args = settings.arguments as dynamic;

  switch (settings.name) {
    case StartPage.routeName:
      return _FadeRoute(const StartPage(), settings);
    case ManagePage.routeName:
      return _FadeRoute(const ManagePage(), settings);

    default:
      return _getPageRoute(const StartPage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child, settings);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final RouteSettings routeName;
  _FadeRoute(this.child, this.routeName)
      : super(
          settings: RouteSettings(
              name: routeName.name, arguments: routeName.arguments),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
