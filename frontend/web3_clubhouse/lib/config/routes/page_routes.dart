import 'package:flutter/material.dart';

typedef PageBuilder = Widget Function();

class PageRoutes {
  static const double defaultDuration = .35;
  static const Curve defaultEaseForward = Curves.easeOut;
  static const Curve defaultEaseReverse = Curves.easeOut;

  static Duration _getDuration(double duration) {
    return Duration(milliseconds: (duration * 1000).round());
  }

  static Route<T> fade<T>(PageBuilder pageBuilder, RouteSettings routeSettings,
      [double duration = defaultDuration]) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
      settings: routeSettings,
      transitionDuration: PageRoutes._getDuration(duration),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
