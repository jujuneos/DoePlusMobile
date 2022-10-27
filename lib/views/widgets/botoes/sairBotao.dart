// ignore: file_names
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/telas/telaBusca.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/escolhaCadastroView.dart';

class SairBotao extends StatefulWidget {
  const SairBotao({Key? key}) : super(key: key);

  @override
  State<SairBotao> createState() => _SairBotaoState();
}

class _SairBotaoState extends State<SairBotao> {
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
              globalKey = GlobalKey();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CadastroView()));
            },
            child: const Text("Sair",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'HammersmithOne',
                    color: Colors.white,
                    fontSize: 25)),
          ),
        ));
  }
}
