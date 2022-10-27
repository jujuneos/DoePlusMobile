import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastGenerico {
  static void mostrarMensagemSucesso(String descricao,
      {ToastGravity gravity = ToastGravity.CENTER,
      Color backgroundColor = Colors.green,
      Color textColor = Colors.white,
      double fontSize = 16,
      bool? longaDuracao}) {
    Fluttertoast.showToast(
        msg: descricao,
        toastLength:
            longaDuracao == true ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }

  static void mostrarMensagemErro(String descricao,
      {ToastGravity gravity = ToastGravity.CENTER,
      Color backgroundColor = Colors.red,
      Color textColor = Colors.white,
      double fontSize = 16,
      bool? longaDuracao}) {
    Fluttertoast.showToast(
        msg: descricao,
        toastLength:
            longaDuracao == true ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }
}
