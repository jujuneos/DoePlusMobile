// ignore: file_names
import 'package:doeplus/telas/telaBusca.dart';
import 'package:doeplus/views/widgets/botoes/cadastroOngBotao.dart';
import 'package:doeplus/views/widgets/botoes/cadastroUsuarioBotao.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/inicioView.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({Key? key}) : super(key: key);

  @override
  _CadastroViewState createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView>
    with AutomaticKeepAliveClientMixin<CadastroView> {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  globalKey = GlobalKey();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InicioView()));
                },
                icon: const Icon(Icons.arrow_back)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme:
                const IconThemeData(color: Color.fromRGBO(204, 14, 221, 10))),
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(36),
                    child: Form(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          const Text("O que deseja cadastrar?",
                              style: TextStyle(
                                color: Color.fromRGBO(204, 14, 221, 10),
                                fontFamily: 'HammersmithOne',
                                fontSize: 34,
                              )),
                          Container(height: 50),
                          Column(
                            children: const [
                              CadastroUsuarioBotao(),
                              CadastroOngBotao()
                            ],
                          )
                        ]))))));
  }

  @override
  bool get wantKeepAlive => true;
}
