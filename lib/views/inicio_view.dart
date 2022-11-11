import 'package:flutter/material.dart';
import 'package:doeplus/views/widgets/widget_navegacao.dart';
import 'package:doeplus/views/widgets/botoes/busca_botao.dart';
import 'package:doeplus/views/widgets/botoes/cadastro_botao.dart';
import 'package:doeplus/views/widgets/botoes/entra_botao.dart';

class InicioView extends StatefulWidget {
  const InicioView({Key? key}) : super(key: key);

  @override
  _InicioViewState createState() => _InicioViewState();
}

class _InicioViewState extends State<InicioView> {
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
                            CadastroBotao(),
                            EntraBotao()
                          ],
                        )
                      ]),
                    )))),
      ),
    );
  }
}
