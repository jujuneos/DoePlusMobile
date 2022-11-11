// ignore: file_names
import 'package:doeplus/styles/tema/default_theme.dart';
import 'package:doeplus/views/cadastro_usuario_view.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioBotao extends StatefulWidget {
  const CadastroUsuarioBotao({Key? key}) : super(key: key);

  @override
  State<CadastroUsuarioBotao> createState() => _CadastroUsuarioBotaoState();
}

class _CadastroUsuarioBotaoState extends State<CadastroUsuarioBotao> {
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
              globalUsuarioKey = GlobalKey();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CadastroUsuarioView()));
            },
            child: const Text("Usuário",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'HammersmithOne',
                    color: Colors.white,
                    fontSize: 25)),
          ),
        ));
  }
}
