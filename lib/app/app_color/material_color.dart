import 'package:flutter/material.dart';

class AppMaterialColor {
  static const MaterialColor primary =
      MaterialColor(_primaryPrimaryValue, <int, Color>{
    50: Color(0xFFEAEDFF),
    100: Color(0xFFCBD3FF),
    200: Color(0xFFA9B6FF),
    300: Color(0xFF8799FE),
    400: Color(0xFF6D83FE),
    500: Color(_primaryPrimaryValue),
    600: Color(0xFF4C65FE),
    700: Color(0xFF425AFE),
    800: Color(0xFF3950FE),
    900: Color(0xFF293EFD),
  });
  static const int _primaryPrimaryValue = 0xFF536DFE;

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_primaryAccentValue),
    400: Color(0xFFD4D8FF),
    700: Color(0xFFBBC1FF),
  });
  static const int _primaryAccentValue = 0xFFFFFFFF;
}
