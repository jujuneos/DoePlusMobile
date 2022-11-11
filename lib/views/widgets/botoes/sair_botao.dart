import 'package:doeplus/controllers/login_controller.dart';
import 'package:doeplus/services/autenticacao_service.dart';
import 'package:doeplus/styles/tema/default_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

class SairBotao extends StatefulWidget {
  const SairBotao({Key? key}) : super(key: key);

  @override
  State<SairBotao> createState() => _SairBotaoState();
}

class _SairBotaoState extends State<SairBotao> {
  final service = Get.put(AutenticacaoService());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(244, 244, 244, 10),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
            onPressed: () {
              Loader.show(context,
                  progressIndicator: CircularProgressIndicator(
                      color: DefaultTheme.getColor()));
              tokenGlobal = null;
              userGlobal = null;
              service.logout(context);
            },
            child: const Text("Sair",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'HammersmithOne',
                    color: Color.fromRGBO(204, 14, 221, 10),
                    fontSize: 25)),
          ),
        ));
  }
}
