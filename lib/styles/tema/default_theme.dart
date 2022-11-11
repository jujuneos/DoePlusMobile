// ignore: file_names
import 'package:flutter/material.dart';

class DefaultTheme {
  static const Color _color = Color.fromRGBO(204, 14, 221, 10);

  static Color getColor() => _color;

  static final ThemeData _theme = ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(204, 14, 221, 10),
          secondary: Colors.white));

  static ThemeData getTheme() => _theme;
}
