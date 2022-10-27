import 'dart:convert';

UsuarioLogin usuarioFromJson(String str) =>
    UsuarioLogin.fromJson(json.decode(str));

class UsuarioLogin {
  String nome;
  String senha;

  UsuarioLogin({required this.nome, required this.senha});

  factory UsuarioLogin.fromJson(Map<dynamic, dynamic> json) {
    return UsuarioLogin(nome: json["nome"], senha: json["senha"]);
  }
}
