import 'package:flutter/cupertino.dart';

import '../../config/routes/route_setting.dart';
import '../../constants/route_names.dart';

extension GetRoute on RouteSettings {
  Route getRoute() {
    if (routeNames.containsKey(this.name)) {
      return routeNames[this.name!]!(this);
    }

    return routeNames[Routes.home]!(this);
  }
}
