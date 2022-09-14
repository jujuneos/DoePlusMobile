import 'package:doeplus/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/AutenticacaoService.dart';

class CadastroUsuarioController extends GetxController {
  AutenticacaoService auth = AutenticacaoService();

  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLogin = true.obs;
  var isLoading = false.obs;

  registrar() async {
    isLoading.value = true;
    await auth.cadastrarUsuario(
        Usuario(nome: nome.text, email: email.text, senha: senha.text));
    isLoading.value = false;
  }

  toogleRegistrar() {
    isLogin.value = !isLogin.value;
  }
}
