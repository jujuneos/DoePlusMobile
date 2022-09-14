import 'package:doeplus/models/ong.dart';
import 'package:doeplus/services/AutenticacaoService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroOngController extends GetxController {
  AutenticacaoService auth = AutenticacaoService();

  final nome = TextEditingController();
  final telefone = TextEditingController();
  final tipo = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final descricao = TextEditingController();
  final endereco = TextEditingController();
  final chavePix = TextEditingController();
  final banco = TextEditingController();
  final conta = TextEditingController();
  final agencia = TextEditingController();
  final picPay = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLogin = true.obs;
  var isLoading = false.obs;

  registrar(var lat, var lng, String foto) async {
    isLoading.value = true;
    await auth.cadastrarOng(Ong(
        nome: nome.text,
        email: email.text,
        senha: senha.text,
        descricao: descricao.text,
        endereco: endereco.text,
        tipo: tipo.text,
        telefone: telefone.text,
        latitude: lat,
        longitude: lng,
        foto: foto,
        chavePix: chavePix.text,
        banco: banco.text,
        agencia: agencia.text,
        conta: conta.text,
        picPay: picPay.text));
    isLoading.value = false;
  }

  toogleRegistrar() {
    isLogin.value = !isLogin.value;
  }

  limparDados() {
    nome.text = "";
    email.text = "";
    senha.text = "";
    descricao.text = "";
    endereco.text = "";
    tipo.text = "";
    telefone.text = "";
    chavePix.text = "";
    banco.text = "";
    agencia.text = "";
    conta.text = "";
    picPay.text = "";
  }
}
