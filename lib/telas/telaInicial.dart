// ignore: file_names
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/views/splashView.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Doe+',
        debugShowCheckedModeBanner: false,
        theme: DefaultTheme.getTheme(),
        home: const SplashView());
  }
}
