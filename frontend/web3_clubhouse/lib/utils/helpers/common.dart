import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension Common on Enum {
  String getJsonValue() {
    return toString().split(".")[1];
  }
}

extension Snackbar on BuildContext {
  void showSnackbar(BuildContext context, String text, [Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 1),
      content: Text(text),
    ));
  }

  Rect? get globalPaintBounds {
    final renderObject = findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      // final offset = Offset(0, 0);
      return renderObject!.paintBounds.shift(offset);
    } else {
      return null;
    }
  }
}

class CommonHelper {
  static final Random _random = Random.secure();

  static String createCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }

  static String createUniqueCryptoRandomString(
      {required List<String> arr, int length = 32}) {
    String uniqString = CommonHelper.createCryptoRandomString(length);
    if (arr.indexOf(uniqString) > 0) {
      uniqString =
          CommonHelper.createUniqueCryptoRandomString(arr: arr, length: length);
    }
    return uniqString;
  }
}
