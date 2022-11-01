import 'package:doeplus/models/usuarioLogin.dart';
import 'package:doeplus/services/AutenticacaoService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  AutenticacaoService auth = AutenticacaoService();
  UsuarioLogin? usuario;

  final email = TextEditingController();
  final senha = TextEditingController();
  final loginKey = GlobalKey<FormState>();

  var botaoPrincipal = 'Entrar'.obs;
  var isLogin = true.obs;
  var isLoading = false.obs;

  login() async {
    await auth.fazerLogin(email.text, senha.text, usuario);
  }

  limparDados() {
    email.text = "";
    senha.text = "";
  }
}
