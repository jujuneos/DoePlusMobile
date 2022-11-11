// ignore: file_names
import 'package:doeplus/controllers/login_controller.dart';
import 'package:doeplus/controllers/ongs_controller.dart';
import 'package:doeplus/styles/tema/default_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

class OngsFavoritasBotao extends StatefulWidget {
  const OngsFavoritasBotao({Key? key}) : super(key: key);

  @override
  State<OngsFavoritasBotao> createState() => _OngsFavoritasBotaoState();
}

class _OngsFavoritasBotaoState extends State<OngsFavoritasBotao> {
  final controller = Get.put(OngsController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20),
          color: DefaultTheme.getColor(),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
            onPressed: () {
              Loader.show(context,
                  progressIndicator: CircularProgressIndicator(
                      color: DefaultTheme.getColor()));
              controller.favoritas(tokenGlobal!, context);
            },
            child: const Text("ONGs Favoritas",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'HammersmithOne',
                    color: Colors.white,
                    fontSize: 25)),
          ),
        ));
  }
}
