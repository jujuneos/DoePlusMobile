// ignore: file_names

import 'package:doeplus/controllers/CadastroUsuarioController.dart';
import 'package:doeplus/styles/fontes/fontDefaultStyles.dart';
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/telas/telaBusca.dart';
import 'package:doeplus/viewModels/cadastroViewModel.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/inicioView.dart';
import 'package:get/get.dart';
import 'package:doeplus/utils/toast.dart';

// ignore: must_be_immutable
class CadastroUsuarioView extends StatefulWidget {
  const CadastroUsuarioView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CadastroUsuarioView();
}

class _CadastroUsuarioView extends State<CadastroUsuarioView> {
  var model = CadastroViewModel();
  final controller = Get.put(CadastroUsuarioController());
  bool mostraSenha = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
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
                    title: const Text("Doe+"),
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
                                    labelText: 'Nome'),
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Informe um nome!';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.email,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'E-mail'),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Informe um E-mail!';
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
                                        controller.registrar();
                                        ToastGenerico.mostrarMensagemSucesso(
                                            "Usuário cadastrado com sucesso!");
                                        Navigator.pop(context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const InicioView()));
                                        controller.limparDados();
                                        globalKey = GlobalKey();
                                      } else {
                                        ToastGenerico.mostrarMensagemErro(
                                            "Erro! Usuário não cadastrado.");
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

  @override
  bool get wantKeepAlive => true;
}
