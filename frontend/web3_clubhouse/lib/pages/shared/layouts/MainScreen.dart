import 'package:flutter/material.dart';
import 'main_layout.dart';

class MainScreen extends MainLayout {
  MainScreen(Widget body) : super(_content(child: body));

  static Widget _content({Widget child = const SizedBox.shrink()}) {
    return Container(
      // margin: EdgeInsets.only(bottom: 10),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/game_area.png"),
      //     fit: BoxFit.fill,
      //   ),
      // ),
      child: child,
    );
  }
}
