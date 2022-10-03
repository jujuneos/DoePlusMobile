import 'dart:convert';

import 'package:doeplus/models/ong.dart';
import 'package:doeplus/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class AutenticacaoService {
  cadastrarOng(Ong ong) async {
    FormData formData = FormData.fromMap({
      "nome": ong.nome,
      "email": ong.email,
      "senha": ong.senha,
      "tipo": ong.tipo,
      "descricao": ong.descricao,
      "endereco": ong.endereco,
      "telefone": ong.telefone,
      "latitude": ong.latitude,
      "longitude": ong.longitude,
      "chavePix": ong.chavePix,
      "banco": ong.banco,
      "agencia": ong.agencia,
      "conta": ong.conta,
      "picPay": ong.picPay
    });

    if (ong.fotos.isNotEmpty) {
      for (var foto in ong.fotos) {
        formData.files.add(MapEntry(
            "fotos",
            await MultipartFile.fromFile(foto.path,
                filename: foto.name, contentType: MediaType("image", "jpeg"))));
      }
    }

    Response response;
    Dio dio = Dio();

    response = await dio.post(
        "https://doeplusapi.herokuapp.com/api/Autenticacao/cadastrarInstituicao",
        data: formData,
        options: Options(
            headers: {'accept': "*/*", "Content-type": "application/json"}));
    if (response.statusCode == 200) {
      showSnack("Sucesso", "Instituição cadastrada com sucesso!");
    } else {
      showSnack("Erro", "Não foi possível cadastrar a Instituição.");
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

  showSnack(String titulo, String mensagem) {
    final snackbar = SnackBar(
      content: Text(titulo + '\n' + mensagem),
      backgroundColor: Colors.white,
      elevation: 100,
      action: SnackBarAction(
        label: 'Voltar',
        onPressed: () {},
      ),
    );
    return snackbar;
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
