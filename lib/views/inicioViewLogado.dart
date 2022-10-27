// ignore: file_names
import 'package:doeplus/views/widgets/botoes/ongsFavoritasBotao.dart';
import 'package:doeplus/views/widgets/botoes/sairBotao.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/widgets/widgetNavegacao.dart';
import 'package:doeplus/views/widgets/botoes/buscaBotao.dart';

class InicioViewLogado extends StatefulWidget {
  const InicioViewLogado({Key? key}) : super(key: key);

  @override
  _InicioViewLogadoState createState() => _InicioViewLogadoState();
}

class _InicioViewLogadoState extends State<InicioViewLogado> {
  @override
  Widget build(BuildContext context) {
    return _inicioScreen();
  }

  Widget _inicioScreen() {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(
                    color: Color.fromRGBO(204, 14, 221, 10))),
            drawer: const NavegacaoWidget(),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(80, 0, 80, 10),
                    child: Form(
                      child: Column(children: <Widget>[
                        const Text("Doe+",
                            style: TextStyle(
                              color: Color.fromRGBO(204, 14, 221, 10),
                              fontFamily: 'HammersmithOne',
                              fontSize: 84,
                            )),
                        SizedBox(
                          height: 180,
                          child: Image.asset("assets/images/doeplus-logo.png"),
                        ),
                        Container(height: 50),
                        // ignore: prefer_const_literals_to_create_immutables
                        Column(
                          children: const [
                            BuscaBotao(),
                            OngsFavoritasBotao(),
                            SairBotao()
                          ],
                        )
                      ]),
                    )))),
      ),
    );
  }
}
