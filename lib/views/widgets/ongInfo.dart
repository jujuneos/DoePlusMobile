import 'package:flutter/material.dart';
import 'package:doeplus/models/ong.dart';

class OngInfo extends StatelessWidget {
  Ong ong;
  OngInfo({Key? key, required this.ong}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Image.network(ong.foto,
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
            padding: const EdgeInsets.only(bottom: 60, left: 24),
            child: Text(ong.endereco)),
      ],
    );
  }
}
