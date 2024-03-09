import 'package:flutter/material.dart';

class DecorationsConstants {
  static final DecorationsConstants _singleton =
      DecorationsConstants._internal();
  DecorationsConstants._internal();
  factory DecorationsConstants() {
    return _singleton;
  }
  final headerTitle = BoxDecoration(
    color: Colors.purple.shade900.withOpacity(0),
    // backgroundBlendMode: BlendMode.lighten,
    //border: Border.all(color: const Color(0x7f1849ea), width: 8),
    // image: DecorationImage(image: SvgConstants().ModalTitleBg),
    boxShadow: const [
      BoxShadow(
          color: Color(0x59000000),
          offset: Offset(-0.7071067811865475, 0.7071067811865476),
          blurRadius: 3,
          spreadRadius: 0),
      BoxShadow(
          color: Color(0x59000000),
          offset: Offset(-0.7071067811865475, 0.7071067811865476),
          blurRadius: 3,
          spreadRadius: 0),
      BoxShadow(
          color: Color(0x59000000),
          offset: Offset(-0.7071067811865475, 0.7071067811865476),
          blurRadius: 3,
          spreadRadius: 0),
      BoxShadow(
          color: Color(0x59000000),
          offset: Offset(-0.7071067811865475, 0.7071067811865476),
          blurRadius: 3,
          spreadRadius: 0),
      BoxShadow(
          color: Color(0x59000000),
          offset: Offset(-0.7071067811865475, 0.7071067811865476),
          blurRadius: 3,
          spreadRadius: 0)
    ],
  );
}
