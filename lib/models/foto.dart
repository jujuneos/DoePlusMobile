import 'dart:convert';

Foto fotoFromJson(String str) => Foto.fromJson(json.decode(str));

String fotoToJson(Foto data) => json.encode(data.toJson());

class Foto {
  int? idFoto;
  String? nome;
  String? tipo;
  double? tamanho;
  String? path;

  Foto({this.idFoto, this.nome, this.tipo, this.tamanho, this.path});

  factory Foto.fromJson(Map<String, dynamic> json) {
    return Foto(idFoto: json["idFoto"], nome: json["nome"], tipo: json["tipo"]);
  }

  Map<String, dynamic> toJson() =>
      {"id": idFoto, "nome": nome, "tipo": tipo, "tamanho": tamanho};
}
