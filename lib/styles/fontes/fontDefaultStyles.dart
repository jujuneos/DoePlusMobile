import 'package:flutter/material.dart';

class FontDefaultStyles {
  static String fontFamily = 'HammersmithOne';

  static TextStyle sm_0() =>
      TextStyle(fontFamily: fontFamily, fontSize: 10.0, letterSpacing: 1);

  static TextStyle sm_1() =>
      TextStyle(fontFamily: fontFamily, fontSize: 13, letterSpacing: 1);

  static TextStyle sm_1_blue() =>
      sm_1().copyWith(color: Colors.blue[900], letterSpacing: 1);

  static TextStyle sm() =>
      TextStyle(fontFamily: fontFamily, fontSize: 16.5, letterSpacing: 1);

  static TextStyle smBold() =>
      sm().copyWith(fontWeight: FontWeight.bold, letterSpacing: 1);

  static TextStyle sm_1Bold() =>
      sm_1().copyWith(fontWeight: FontWeight.bold, letterSpacing: 1);

  static TextStyle md() =>
      TextStyle(fontFamily: fontFamily, fontSize: 27.0, letterSpacing: 1);

  static TextStyle md_1() =>
      TextStyle(fontFamily: fontFamily, fontSize: 23.0, letterSpacing: 1);

  static TextStyle padrao() => md_1().copyWith(
      color: const Color.fromRGBO(204, 14, 221, 10), letterSpacing: 1);
}
