import 'package:doeplus/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/autenticacao_service.dart';

class CadastroUsuarioController extends GetxController {
  AutenticacaoService auth = AutenticacaoService();

  final nome = TextEditingController();
  final senha = TextEditingController();
  final usuarioKey = GlobalKey<FormState>();

  var isLogin = true.obs;

  registrar(BuildContext context) async {
    await auth.cadastrarUsuario(
        Usuario(nome: nome.text, senha: senha.text), context);
  }

  toogleRegistrar() {
    isLogin.value = !isLogin.value;
  }

  limparDados() {
    nome.text = "";
    senha.text = "";
  }
}
