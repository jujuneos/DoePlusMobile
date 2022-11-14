import 'package:doeplus/controllers/ongs_controller.dart';
import 'package:doeplus/styles/tema/default_theme.dart';
import 'package:doeplus/views/inicio_view_logado.dart';
import 'package:doeplus/views/pagina_ong_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

class OngsFavoritasView extends StatefulWidget {
  const OngsFavoritasView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OngsFavoritasView();
}

class _OngsFavoritasView extends State<OngsFavoritasView> {
  final controller = Get.put(OngsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InicioViewLogado()));
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
                  child: Text("Favoritas",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 14, 221, 10),
                          fontFamily: "HammersmithOne",
                          fontSize: 20)))
            ]),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme:
                const IconThemeData(color: Color.fromRGBO(204, 14, 221, 10))),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: controller.ongsFavoritas.isNotEmpty
                  ? controller.ongsFavoritas.map((ong) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.fromLTRB(15, 12, 15, 12),
                              onPressed: () {
                                Loader.show(context,
                                    progressIndicator:
                                        CircularProgressIndicator(
                                            color: DefaultTheme.getColor()));
                                controller.loadDados(ong, context);
                              },
                              child: Text(ong.nome!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'HammersmithOne',
                                      color: DefaultTheme.getColor(),
                                      fontSize: 20))),
                        ),
                      );
                    }).toList()
                  : [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 50, 30, 12),
                        child: Text(
                          "Nenhuma ONG favoritada por este usuário.",
                          style: TextStyle(
                              fontFamily: 'HammersmithOne',
                              color: DefaultTheme.getColor(),
                              fontSize: 20),
                        ),
                      )
                    ]),
        ));
  }
}
