// ignore: file_names
import 'package:doeplus/views/widgets/widgetDadosApp.dart';
import 'package:flutter/material.dart';

class NavegacaoWidget extends StatelessWidget {
  const NavegacaoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 10,
        backgroundColor: Colors.white,
        child: ListView(children: const [DadosApp()]));
  }
}
