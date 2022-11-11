import 'dart:convert';

import 'package:doeplus/controllers/login_controller.dart';
import 'package:doeplus/controllers/ongs_controller.dart';
import 'package:doeplus/models/ong_view.dart';
import 'package:doeplus/styles/tema/default_theme.dart';
import 'package:doeplus/telas/tela_busca.dart';
import 'package:doeplus/utils/toast.dart';
import 'package:doeplus/views/avaliacao_view.dart';
import 'package:doeplus/views/inicio_view.dart';
import 'package:doeplus/views/inicio_view_logado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

GlobalKey ongKey = GlobalKey();

// ignore: must_be_immutable
class PaginaOngView extends StatelessWidget {
  OngView ong;
  PaginaOngView({Key? key, required this.ong}) : super(key: key);
  final controller = Get.put(OngsController());

  void _launchURL(var url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível ir até $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: ongKey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (tokenGlobal != null) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InicioViewLogado()));
                } else {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InicioView()));
                }
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
                onPressed: () {
                  if (userGlobal != null) {
                    Loader.show(context,
                        progressIndicator: CircularProgressIndicator(
                            color: DefaultTheme.getColor()));
                    controller.favoritar(ong, tokenGlobal ?? "");
                  } else {
                    ToastGenerico.mostrarMensagemErro(
                        "Login é necessário para favoritar uma instituição.");
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                          width: 200,
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
                        padding: const EdgeInsets.fromLTRB(60, 10, 10, 10),
                        child: Material(
                            color: const Color.fromARGB(255, 250, 250, 250),
                            child: MaterialButton(
                                onPressed: () {
                                  if (userGlobal != null) {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AvaliacaoView(ong: ong)));
                                  } else {
                                    ToastGenerico.mostrarMensagemErro(
                                        "Login é necessário para avaliar uma instituição.");
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text("Fotos",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 14, 221, 10),
                          fontFamily: 'HammersmithOne',
                          fontSize: 30))),
            ),
            Row(children: <Widget>[
              Expanded(
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Toque e segure para copiar.",
                        style: TextStyle(
                            color: Color.fromARGB(90, 0, 0, 0),
                            fontFamily: 'HammersmithOne',
                            fontSize: 16)))),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
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
            if (ong.site!.isNotEmpty)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                        child: Text(
                            ong.site!.startsWith("www")
                                ? "Site: ${ong.site}"
                                : "Instagram: ${ong.site}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'HammersmithOne',
                                fontSize: 20)),
                        onTap: () {
                          if (ong.site!.startsWith("www")) {
                            _launchURL(Uri.parse("https://${ong.site!}"));
                          } else {
                            _launchURL(Uri.parse(
                                "https://www.instagram.com/${ong.site!}"));
                          }
                        })),
              ),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text("Dados para doação",
                        style: TextStyle(
                            color: Color.fromRGBO(204, 14, 221, 10),
                            fontFamily: 'HammersmithOne',
                            fontSize: 30)))),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Toque e segure para copiar.",
                        style: TextStyle(
                            color: Color.fromARGB(90, 0, 0, 0),
                            fontFamily: 'HammersmithOne',
                            fontSize: 16)))),
            if (ong.chavePix!.isNotEmpty)
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: GestureDetector(
                          child: Text("Chave Pix: ${ong.chavePix}",
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
            if (ong.banco!.isNotEmpty)
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: GestureDetector(
                          child: Text("Banco: ${ong.banco}",
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
            if (ong.agencia!.isNotEmpty)
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: GestureDetector(
                          child: Text("Agência: ${ong.agencia}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'HammersmithOne',
                                  fontSize: 20)),
                          onLongPress: () {
                            if (ong.agencia != null) {
                              Clipboard.setData(
                                  ClipboardData(text: ong.agencia));
                              ToastGenerico.mostrarMensagemSucesso("Copiado!");
                            }
                          }))),
            if (ong.conta!.isNotEmpty)
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: GestureDetector(
                          child: Text("Conta: ${ong.conta}",
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
            if (ong.picPay!.isNotEmpty)
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: GestureDetector(
                          child: Text("PicPay: ${ong.picPay}",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 8, 212, 18),
                                  fontFamily: 'HammersmithOne',
                                  fontSize: 20)),
                          onTap: () {
                            _launchURL(
                                Uri.parse('https://picpay.me/${ong.picPay}'));
                          }))),
            Padding(
                padding: const EdgeInsets.fromLTRB(80, 15, 80, 10),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                      onPressed: () {
                        globalKey = GlobalKey();
                        Navigator.pop(context);
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
