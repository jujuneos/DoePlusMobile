import 'dart:convert';
import 'dart:io';

import 'package:doeplus/models/ong.dart';
import 'package:doeplus/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AutenticacaoService {
  cadastrarOng(Ong ong) {
    try {
      http.post(
          Uri.parse(
              'https://doeplusapi.herokuapp.com/api/Autenticacao/cadastrarInstituicao'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "nome": ong.nome,
            "email": ong.email,
            "senha": ong.senha,
            "tipo": ong.tipo,
            "descricao": ong.descricao,
            "endereco": ong.endereco,
            "foto": ong.foto,
            "telefone": ong.telefone,
            "latitude": ong.latitude,
            "longitude": ong.longitude,
            "chavePix": ong.chavePix,
            "banco": ong.banco,
            "agencia": ong.agencia,
            "conta": ong.conta,
            "picPay": ong.picPay
          }));
    } catch (e) {
      showSnack('Erro ao registrar!', e.toString());
    }
  }

  cadastrarUsuario(Usuario usuario) {
    try {
      http.post(
          Uri.parse(
              'https://doeplusapi.herokuapp.com/api/Autenticacao/cadastrarUsuario'),
          body: jsonEncode({
            "nome": usuario.nome,
            "email": usuario.email,
            "senha": usuario.senha
          }));
    } catch (e) {
      showSnack('Erro ao registrar!', e.toString());
    }
  }

  showSnack(String titulo, String erro) {
    Get.snackbar(titulo, erro,
        backgroundColor: Colors.white,
        colorText: Colors.purple,
        snackPosition: SnackPosition.BOTTOM);
  }

  fazerLogin(String email, String senha) {
    try {
      http.post(
          Uri.parse('https://doeplusapi.herokuapp.com/api/Autenticacao/login'),
          body: jsonEncode({"email": email, "senha": senha}));
    } catch (e) {
      showSnack('Erro no login!', e.toString());
    }
  }
}
