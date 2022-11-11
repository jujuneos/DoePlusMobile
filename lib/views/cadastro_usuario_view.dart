import 'package:doeplus/controllers/cadastro_usuario_controller.dart';
import 'package:doeplus/styles/fontes/font_default_styles.dart';
import 'package:doeplus/styles/tema/default_theme.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/inicio_view.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

GlobalKey globalUsuarioKey = GlobalKey();

// ignore: must_be_immutable
class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CadastroUsuarioView();
}

class _CadastroUsuarioView extends State<CadastroUsuarioView> {
  final controller = Get.put(CadastroUsuarioController());
  bool mostraSenha = false;

  @override
  Widget build(BuildContext context) {
    globalUsuarioKey = GlobalKey();
    return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
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
                              child: Image.asset(
                                  "assets/images/doeplus-logo.png"))),
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
                    iconTheme: const IconThemeData(
                        color: Color.fromRGBO(204, 14, 221, 10))),
                body: Form(
                    key: controller.usuarioKey,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.nome,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Usuário'),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Informe um usuário!';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(60, 15, 60, 1),
                            child: Text(
                                "A senha deve conter 8 ou mais caracteres, pelo menos uma letra maiúscula, um número e um caractere especial.",
                                style: FontDefaultStyles.sm_2()),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.senha,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                        onTap: visibilidadeSenha,
                                        child: Icon(mostraSenha
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Senha'),
                                obscureText:
                                    mostraSenha == false ? true : false,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Informe sua senha!';
                                  } else if (value.toString().length < 8) {
                                    return 'Sua senha deve ter no mínimo 8 caracteres';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(80, 0, 80, 10),
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(20),
                                color: DefaultTheme.getColor(),
                                child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 12, 15, 12),
                                    onPressed: () {
                                      if (controller.usuarioKey.currentState!
                                          .validate()) {
                                        Loader.show(context,
                                            progressIndicator:
                                                CircularProgressIndicator(
                                                    color: DefaultTheme
                                                        .getColor()));
                                        controller.registrar(context);
                                        controller.limparDados();
                                      }
                                    },
                                    child: const Text("Registrar",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'HammersmithOne',
                                            color: Colors.white,
                                            fontSize: 25))),
                              ))
                        ]))))));
  }

  void visibilidadeSenha() {
    setState(() {
      mostraSenha = !mostraSenha;
    });
  }
}
