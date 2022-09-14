// ignore: file_names
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/telas/telaBusca.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuscaBotao extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  const BuscaBotao({Key? key}) : super(key: key);

  @override
  State<BuscaBotao> createState() => _BuscaBotaoState();
}

class _BuscaBotaoState extends State<BuscaBotao> {
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TelaBusca()));
            },
            child: const Text("Buscar ONGs",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'HammersmithOne',
                    color: Colors.white,
                    fontSize: 25)),
          ),
        ));
  }
}
