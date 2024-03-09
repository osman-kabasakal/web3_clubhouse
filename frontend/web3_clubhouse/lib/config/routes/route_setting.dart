import 'package:flutter/material.dart';
import 'package:web3_clubhouse/pages/home/home_screen.dart';

import '../../constants/route_names.dart';
import 'page_routes.dart';

final Map<String, Route Function(RouteSettings)> routeNames = {
  Routes.home: (route) =>
      PageRoutes.fade<HomeScreen>(() => const HomeScreen(), route),

};
