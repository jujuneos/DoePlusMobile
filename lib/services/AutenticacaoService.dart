import 'dart:convert';
import 'dart:io';

import 'package:doeplus/models/ong.dart';
import 'package:doeplus/models/usuario.dart';
import 'package:doeplus/models/usuarioLogin.dart';
import 'package:doeplus/utils/toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AutenticacaoService {
  static const url = "https://doeplusapi.herokuapp.com/api/";

  cadastrarOng(Ong ong) async {
    var urlCadastro = url + "Autenticacao/cadastrarInstituicao";

    var request = http.MultipartRequest('POST', Uri.parse(urlCadastro));

    request.headers['Content-Type'] =
        "multipart/form-data; boundary=<calculated when request is sent>";

    request.fields['nome'] = ong.nome;
    request.fields['email'] = ong.email;
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
    request.fields['qtdAvaliacao'] = ong.qtdAvaliacao.toString();
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

    await request.send();
  }

  cadastrarUsuario(Usuario usuario) async {
    var urlCadastroUser =
        "https://doeplusapi.herokuapp.com/api/Autenticacao/cadastrarUsuario";

    await http.post(Uri.parse(urlCadastroUser),
        body: jsonEncode({
          "nome": usuario.nome,
          "email": usuario.email,
          "senha": usuario.senha
        }),
        headers: {"Content-Type": "application/json"});
  }

  fazerLogin(String email, String senha) async {
    try {
      var prefs = SharedPreferences.getInstance();
      var usuario;

      var response = await http.post(
          Uri.parse('https://doeplusapi.herokuapp.com/api/Autenticacao/login'),
          body: jsonEncode({"email": email, "senha": senha}),
          headers: {"Content-Type": "application/json"});

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        usuario = UsuarioLogin.fromJson(mapResponse);
      }
      ToastGenerico.mostrarMensagemSucesso("Login efetuado com sucesso.");
    } catch (e) {
      ToastGenerico.mostrarMensagemErro(e.toString());
    }
  }
}
