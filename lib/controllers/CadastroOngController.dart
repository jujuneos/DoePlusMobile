import 'package:doeplus/models/foto.dart';
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
  final site = TextEditingController();
  final cadastroKey = GlobalKey<FormState>();

  var isLogin = true.obs;

  registrar(var lat, var lng, List<Foto> fotos) async {
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
        chavePix: chavePix.text,
        banco: banco.text,
        agencia: agencia.text,
        conta: conta.text,
        picPay: picPay.text,
        site: site.text,
        avaliacao: 0.0,
        qtdAvaliacao: 0,
        avaliacaoTotal: 0,
        fotos: fotos));
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
