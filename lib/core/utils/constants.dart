import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color get transparent => Colors.transparent;
  static const primaryColor = Color(0xff0A84FF);
  static const primaryLightColor = Color(0xffa6d5e5);
  static const secondaryColor = Color(0xffD7FFD7);
  static const splashBackgroundColor = Color(0xff38A700);
  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
  static const gray = Color(0xffF5F5F5);
  static const grayLight = Color(0xffACA9A9);
  static const yellow = Color(0xffDFB534);
  static const red = Color(0xffFF0000);
  static const green = Color(0xff38A700);
  static const blue = Color(0xff0058FF);
  static const brown = Color(0xffD35454);

  static Color custom(String code) {
    final color = code.replaceAll('#', '');
    return Color(int.parse('0xFF$color'));
  }

  static Color get random {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }
}
