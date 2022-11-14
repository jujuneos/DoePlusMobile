import 'dart:convert';
import 'dart:io';

import 'package:doeplus/models/ong.dart';
import 'package:doeplus/models/usuario.dart';
import 'package:doeplus/models/usuario_login.dart';
import 'package:doeplus/utils/toast.dart';
import 'package:doeplus/views/inicio_view.dart';
import 'package:doeplus/views/inicio_view_logado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;

class AutenticacaoService {
  static const url = "https://doeplusapi.herokuapp.com/api/";

  cadastrarOng(Ong ong, BuildContext context) async {
    var urlCadastro = url + "Autenticacao/cadastrarInstituicao";

    var request = http.MultipartRequest('POST', Uri.parse(urlCadastro));

    request.headers['Content-Type'] =
        "multipart/form-data; boundary=<calculated when request is sent>";

    request.fields['nome'] = ong.nome;
    request.fields['UserName'] = ong.email;
    request.fields['senha'] = ong.senha;
    request.fields['tipo'] = ong.tipo;
    request.fields['descricao'] = ong.descricao;
    request.fields['endereco'] = ong.endereco;
    request.fields['telefone'] = ong.telefone;
    request.fields['site'] = ong.site!;
    request.fields['latitude'] = ong.latitude.toString();
    request.fields['longitude'] = ong.longitude.toString();
    request.fields['avaliacao'] = ong.avaliacao.toString();
    request.fields['avaliacaoTotal'] = ong.avaliacaoTotal.toString();
    request.fields['qtdAvaliacoes'] = ong.qtdAvaliacao.toString();
    request.fields['chavePix'] = ong.chavePix!;
    request.fields['banco'] = ong.banco!;
    request.fields['agencia'] = ong.agencia!;
    request.fields['conta'] = ong.conta!;
    request.fields['picPay'] = ong.picPay!;

    if (ong.fotos.isNotEmpty) {
      for (var foto in ong.fotos) {
        request.files.add(http.MultipartFile.fromBytes(
            'fotos', File(foto.path!).readAsBytesSync(),
            filename: foto.path));
      }
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      ToastGenerico.mostrarMensagemSucesso("ONG cadastrada com sucesso!");
      Loader.hide();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const InicioView()));
    } else {
      Loader.hide();
      ToastGenerico.mostrarMensagemErro("Erro interno! ONG não cadastrada.");
    }
  }

  cadastrarUsuario(Usuario usuario, BuildContext context) async {
    var urlCadastroUser =
        "https://doeplusapi.herokuapp.com/api/Autenticacao/cadastrarUsuario";

    var response = await http.post(Uri.parse(urlCadastroUser),
        body: jsonEncode({"nome": usuario.nome, "senha": usuario.senha}),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      Loader.hide();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const InicioView()));
      ToastGenerico.mostrarMensagemSucesso("Usuário cadastrado com sucesso!");
    } else {
      Loader.hide();
      print(response.body);
      ToastGenerico.mostrarMensagemErro("Erro! Usuário não cadastrado.");
    }
  }

  Future<UsuarioLogin> fazerLogin(
      String user, String senha, BuildContext context) async {
    UsuarioLogin? usuario;
    try {
      var response = await http.post(Uri.parse(url + 'Autenticacao/login'),
          body: jsonEncode({"UserName": user, "senha": senha}),
          headers: {"Content-Type": "application/json"});

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        usuario = UsuarioLogin.fromJson(mapResponse);
        ToastGenerico.mostrarMensagemSucesso("Login efetuado com sucesso.");
        Loader.hide();
        Navigator.pop(context);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const InicioViewLogado()));
        return usuario;
      }
      return usuario!;
    } catch (error) {
      Loader.hide();
      ToastGenerico.mostrarMensagemErro("Erro ao fazer login.");
      return usuario!;
    }
  }

  logout(BuildContext context) async {
    var response = await http.post(Uri.parse(url + 'Autenticacao/logout'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      ToastGenerico.mostrarMensagemSucesso("Logout efetuado com sucesso.");
      Loader.hide();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const InicioView()));
    }
  }
}
