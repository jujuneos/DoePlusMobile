// ignore: file_names
import 'package:doeplus/controllers/LoginController.dart';
import 'package:doeplus/styles/fontes/fontDefaultStyles.dart';
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/telas/telaBusca.dart';
import 'package:doeplus/utils/toast.dart';
import 'package:doeplus/views/inicioViewLogado.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/inicioView.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final controller = Get.put(LoginController());
  bool mostraSenha = false;

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
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: controller.loginKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
                          child: TextFormField(
                            controller: controller.email,
                            style: FontDefaultStyles.sm(),
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                labelText: 'E-mail'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'E-mail não informado!';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
                          child: TextFormField(
                            controller: controller.senha,
                            style: FontDefaultStyles.sm(),
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: visibilidadeSenha,
                                    child: Icon(mostraSenha
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                labelText: 'Senha'),
                            obscureText: mostraSenha == false ? true : false,
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
                          padding: const EdgeInsets.fromLTRB(80, 15, 80, 10),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            color: DefaultTheme.getColor(),
                            child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.fromLTRB(15, 12, 15, 12),
                                onPressed: () {
                                  if (controller.loginKey.currentState !=
                                      null) {
                                    if (controller.isLogin.value) {
                                      controller.login();
                                      ToastGenerico.mostrarMensagemSucesso(
                                          "Login efetuado com sucesso!");
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const InicioViewLogado()));
                                      controller.limparDados();
                                      globalKey = GlobalKey();
                                    } else {
                                      ToastGenerico.mostrarMensagemErro(
                                          "Verifique seus dados.");
                                    }
                                  }
                                },
                                child: const Text("Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'HammersmithOne',
                                        color: Colors.white,
                                        fontSize: 25))),
                          ))
                    ]))));
  }

  void visibilidadeSenha() {
    setState(() {
      mostraSenha = !mostraSenha;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
