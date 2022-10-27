import 'dart:convert';

import 'package:doeplus/models/ongView.dart';
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/telas/telaBusca.dart';
import 'package:doeplus/views/paginaOngView.dart';
import 'package:flutter/material.dart';

class OngInfo extends State {
  OngView ong;
  OngInfo({required this.ong}) : super();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Image.memory(base64Decode(ong.foto),
            height: 250,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Padding(
            padding: const EdgeInsets.only(top: 24, left: 24),
            child: Text(
              ong.nome,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 24),
            child: Text(
              ong.endereco,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 24, right: 24),
            child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                color: DefaultTheme.getColor(),
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    onPressed: () {
                      globalKey = GlobalKey();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaginaOngView(ong: ong)));
                    },
                    child: const Text("Selecionar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'HammersmithOne',
                            color: Colors.white,
                            fontSize: 20))))),
      ],
    );
  }
}
