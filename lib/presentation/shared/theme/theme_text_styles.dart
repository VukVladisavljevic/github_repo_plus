import 'colors.dart';
import 'package:flutter/material.dart';

class ThemeTextStyles {
  ThemeTextStyles._();

  static final Headers headers = Headers();
  static final Body body = Body();
}

class Headers {
  final large = TextStyle(color: ThemeColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 24.0);
  final medium = TextStyle(color: ThemeColors.darkBlue, fontWeight: FontWeight.w500, fontSize: 18.0);
  final small = TextStyle(color: ThemeColors.darkBlue, fontWeight: FontWeight.w500, fontSize: 12.0);
}

class Body {
  final largeBolded = TextStyle(color: ThemeColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 16.0);
  final large = TextStyle(color: ThemeColors.darkBlue, fontWeight: FontWeight.w500, fontSize: 16.0);
  final medium = TextStyle(color: ThemeColors.darkBlue, fontWeight: FontWeight.w500, fontSize: 14.0);
}
