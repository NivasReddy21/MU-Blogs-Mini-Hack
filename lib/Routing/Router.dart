import 'package:flutter/material.dart';
import 'package:mu_blogs/Routing/RouteNames.dart';
import 'package:mu_blogs/Screens/BlogPage.dart';
import 'package:mu_blogs/Screens/CreateBlog.dart';
import 'package:mu_blogs/Screens/Home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(MyHomePage());
    case MyBlogsRoute:
      return _getPageRoute(MyBlogsView());
    case CreateRoute:
      return _getPageRoute(CreateView());
    default:
      return _getPageRoute(MyHomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return _FadeRoute(
    child: child,
  );
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  _FadeRoute({required this.child})
      : super(
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
