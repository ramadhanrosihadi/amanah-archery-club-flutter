import 'package:flutter/material.dart';

class VColor {
  static Color colorPrimary = const Color(0xFF004AAD);
  static Color colorPrimaryLight = const Color(0xFF00B8EE);
  static Color? colorPrimaryDark = Colors.blue[700];
  static Color? hintColor = Colors.grey[400];
  static Color accentColor = const Color(0xFFFDD100);
  static Color textColor = const Color(0xFF455A64);
  static Color greyBackgroundNoOpacity = const Color(0xFFCCD6DC);
  static Color greyBackground = const Color(0xFFCCD6DC).withOpacity(0.4);
  static Color textFieldAttribute = const Color(0xFF718F9D);
  // static Color hexToColor(String code) {
  //   return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  // }
}
