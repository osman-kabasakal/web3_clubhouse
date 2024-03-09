import 'package:flutter/cupertino.dart';

import 'di_level.dart';
import 'di_widget_join.dart';

class RegisterDi {
  static final RegisterDi _instance = RegisterDi._internal();
  RegisterDi._internal();
  factory RegisterDi() => _instance;

  List<DiLevel> levels = List.empty();

  Widget activateDi() {
    levels.sort((level1, level2) => level1.order.compareTo(level2.order));

    if (levels.isEmpty) return Container();

    return levels.fold<DiWidgetJoin?>(
        null, (prev, current) => _diLevelWidget(current, prev))!;
  }

  DiWidgetJoin _diLevelWidget(DiLevel level, DiWidgetJoin? parent) {
    if (parent == null) {
      return DiWidgetJoin(child: level);
    }
    return DiWidgetJoin(child: level);
  }
}
