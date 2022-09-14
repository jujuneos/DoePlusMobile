// ignore: file_names
import 'package:doeplus/controllers/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/inicioView.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
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
                key: controller.formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(24),
                          child: TextFormField(
                            controller: controller.email,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: TextFormField(
                            controller: controller.senha,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Senha'),
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
                        padding: const EdgeInsets.all(24.0),
                        child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState != null) {
                                if (controller.isLogin.value) {
                                  controller.login();
                                }
                              }
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Obx(() => Text(
                                    controller.botaoPrincipal.value,
                                    style: const TextStyle(fontSize: 20))))),
                      )
                    ]))));
  }

  @override
  bool get wantKeepAlive => true;
}
