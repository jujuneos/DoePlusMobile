import 'package:doeplus/services/AutenticacaoService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  AutenticacaoService auth = AutenticacaoService();

  final email = TextEditingController();
  final senha = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var botaoPrincipal = 'Entrar'.obs;
  var isLogin = true.obs;
  var isLoading = false.obs;

  login() async {
    isLoading.value = true;
    await auth.fazerLogin(email.text, senha.text);
    isLoading.value = false;
  }
}
