import 'package:doeplus/models/usuario_login.dart';
import 'package:doeplus/services/autenticacao_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var loginKey = GlobalKey<FormState>();
UsuarioLogin? userGlobal;
String? tokenGlobal;

class LoginController extends GetxController {
  AutenticacaoService auth = AutenticacaoService();

  final email = TextEditingController();
  final senha = TextEditingController();

  var botaoPrincipal = 'Entrar'.obs;

  login(BuildContext context) async {
    userGlobal = await auth.fazerLogin(email.text, senha.text, context);
    tokenGlobal = userGlobal!.token;
  }

  limparDados() {
    email.text = "";
    senha.text = "";
  }
}
