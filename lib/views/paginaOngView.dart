// ignore: file_names
import 'dart:convert';

import 'package:doeplus/controllers/LoginController.dart';
import 'package:doeplus/controllers/OngsController.dart';
import 'package:doeplus/models/ongView.dart';
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/utils/toast.dart';
import 'package:doeplus/views/avaliacaoView.dart';
import 'package:doeplus/views/inicioView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:doeplus/telas/telaBusca.dart';

const ongKey1 = Key('chave1');
const ongKey2 = Key('chave2');
const ongKey3 = Key('chave3');
const ongKey4 = Key('chave4');
const ongKey5 = Key('chave5');
const ongKey6 = Key('chave6');
const ongKey7 = Key('chave7');
const ongKey8 = Key('chave8');
const ongKey9 = Key('chave9');
const ongKey10 = Key('chave10');
const ongKey11 = Key('chave11');
const ongKey12 = Key('chave12');
const ongKey13 = Key('chave13');
const ongKey14 = Key('chave14');
const ongKey15 = Key('chave15');
const ongKey16 = Key('chave16');
const ongKey17 = Key('chave17');
const ongKey18 = Key('chave18');

// ignore: must_be_immutable
class PaginaOngView extends StatelessWidget {
  OngView ong;
  PaginaOngView({Key? key, required this.ong}) : super(key: key);
  final controller = Get.put(OngsController());
  final loginController = Get.put(LoginController());

  void _launchURL(var url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Não foi possível ir até $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          key: ongKey1,
          leading: IconButton(
              onPressed: () {
                globalKey = GlobalKey();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InicioView()));
              },
              icon: const Icon(Icons.arrow_back)),
          title: Row(children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(80, 10, 2, 10),
                child: SizedBox(
                    height: 25,
                    child: Image.asset("assets/images/doeplus-logo.png"))),
            const Padding(
                padding: EdgeInsets.fromLTRB(2, 10, 50, 10),
                child: Text("Doe+",
                    style: TextStyle(
                        color: Color.fromRGBO(204, 14, 221, 10),
                        fontFamily: "HammersmithOne",
                        fontSize: 25)))
          ]),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(204, 14, 221, 10)),
          actions: [
            IconButton(
                key: ongKey18,
                onPressed: () {
                  if (loginController.usuario != null) {
                    ToastGenerico.mostrarMensagemErro(
                        "Login é necessário para favoritar uma instituição.");
                  } else {
                    var response = controller.favoritar(
                        ong, loginController.usuario?.token ?? "");
                    if (response == 200) {
                      ToastGenerico.mostrarMensagemSucesso(
                          "ONG adicionada às suas favoritas");
                    } else {
                      ToastGenerico.mostrarMensagemErro("Erro.");
                    }
                  }
                },
                icon: Image.asset("assets/images/heart.png",
                    color: DefaultTheme.getColor()))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                key: ongKey2,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: Text(ong.nome,
                                style: const TextStyle(
                                    color: Color.fromRGBO(204, 14, 221, 10),
                                    fontFamily: 'HammersmithOne',
                                    fontSize: 36)),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(110, 10, 10, 10),
                        child: Material(
                            color: const Color.fromARGB(255, 250, 250, 250),
                            child: MaterialButton(
                                onPressed: () {
                                  globalKey = GlobalKey();
                                  if (loginController.usuario != null) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AvaliacaoView(ong: ong)));
                                  } else {
                                    ToastGenerico.mostrarMensagemErro(
                                        "É necessário estar logado para avaliar.");
                                  }
                                },
                                child: Row(children: <Widget>[
                                  Text(ong.avaliacao.toStringAsPrecision(2),
                                      style: const TextStyle(
                                          color: Color.fromARGB(170, 0, 0, 0),
                                          fontFamily: 'HammersmithOne',
                                          fontSize: 25)),
                                  const Icon(Icons.star, color: Colors.yellow)
                                ]))),
                      )
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey3,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(ong.descricao,
                        style: const TextStyle(
                            color: Color.fromARGB(90, 0, 0, 0),
                            fontFamily: 'HammersmithOne',
                            fontSize: 16)))),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  key: ongKey4,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text("Fotos",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 14, 221, 10),
                          fontFamily: 'HammersmithOne',
                          fontSize: 30))),
            ),
            Row(children: <Widget>[
              Expanded(
                key: ongKey5,
                child: SizedBox(
                  height: 200,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: ong.fotos.map((foto) {
                        return Container(
                            child: Image.memory(base64Decode(foto['bytes']),
                                height: 200, width: 200, fit: BoxFit.cover),
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.all(10));
                      }).toList()),
                ),
              )
            ]),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey13,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Contato",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 14, 221, 10),
                          fontFamily: 'HammersmithOne',
                          fontSize: 30),
                    ))),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey14,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Toque e segure para copiar.",
                        style: TextStyle(
                            color: Color.fromARGB(90, 0, 0, 0),
                            fontFamily: 'HammersmithOne',
                            fontSize: 16)))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey15,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                        child: Text("Telefone: ${ong.telefone}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'HammersmithOne',
                                fontSize: 20)),
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(text: ong.telefone));
                          ToastGenerico.mostrarMensagemSucesso("Copiado!");
                        }))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey16,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                        child: Text(
                            ong.site!.isNotEmpty ? "Site: ${ong.site}" : "",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'HammersmithOne',
                                fontSize: 20)),
                        onLongPress: () {
                          if (ong.site != null) {
                            Clipboard.setData(ClipboardData(text: ong.site));
                            ToastGenerico.mostrarMensagemSucesso("Copiado!");
                          }
                        }))),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey6,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text("Dados para doação",
                        style: TextStyle(
                            color: Color.fromRGBO(204, 14, 221, 10),
                            fontFamily: 'HammersmithOne',
                            fontSize: 30)))),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey7,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Toque e segure para copiar.",
                        style: TextStyle(
                            color: Color.fromARGB(90, 0, 0, 0),
                            fontFamily: 'HammersmithOne',
                            fontSize: 16)))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey8,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                        child: Text(
                            ong.chavePix!.isNotEmpty
                                ? "Chave Pix: ${ong.chavePix}"
                                : "",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'HammersmithOne',
                                fontSize: 20)),
                        onLongPress: () {
                          if (ong.chavePix != null) {
                            Clipboard.setData(
                                ClipboardData(text: ong.chavePix));
                            ToastGenerico.mostrarMensagemSucesso("Copiado!");
                          }
                        }))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey9,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                        child: Text(
                            ong.banco!.isNotEmpty ? "Banco: ${ong.banco}" : "",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'HammersmithOne',
                                fontSize: 20)),
                        onLongPress: () {
                          if (ong.banco != null) {
                            Clipboard.setData(ClipboardData(text: ong.banco));
                            ToastGenerico.mostrarMensagemSucesso("Copiado!");
                          }
                        }))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey10,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                        child: Text(
                            ong.agencia!.isNotEmpty
                                ? "Agência: ${ong.agencia}"
                                : "",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'HammersmithOne',
                                fontSize: 20)),
                        onLongPress: () {
                          if (ong.agencia != null) {
                            Clipboard.setData(ClipboardData(text: ong.agencia));
                            ToastGenerico.mostrarMensagemSucesso("Copiado!");
                          }
                        }))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey11,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                        child: Text(
                            ong.conta!.isNotEmpty ? "Conta: ${ong.conta}" : "",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'HammersmithOne',
                                fontSize: 20)),
                        onLongPress: () {
                          if (ong.conta != null) {
                            Clipboard.setData(ClipboardData(text: ong.conta));
                            ToastGenerico.mostrarMensagemSucesso("Copiado!");
                          }
                        }))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    key: ongKey12,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                        child: Text(
                            ong.picPay!.isNotEmpty
                                ? "PicPay: ${ong.picPay}"
                                : "",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 8, 212, 18),
                                fontFamily: 'HammersmithOne',
                                fontSize: 20)),
                        onTap: () {
                          globalKey = GlobalKey();
                          _launchURL(
                              Uri.parse('https://picpay.me/${ong.picPay}'));
                        }))),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(30, 12, 15, 30),
                      onPressed: () {
                        globalKey = GlobalKey();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TelaBusca()));
                      },
                      child: Text("Voltar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'HammersmithOne',
                              color: DefaultTheme.getColor(),
                              fontSize: 25))),
                ))
          ],
        )));
  }
}
