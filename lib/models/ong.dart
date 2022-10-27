import 'foto.dart';

class Ong {
  String nome;
  String email;
  String senha;
  String tipo;
  String descricao;
  String endereco;
  String telefone;
  String? site;
  double latitude;
  double longitude;
  double avaliacao;
  double avaliacaoTotal;
  int qtdAvaliacao;
  String? chavePix;
  String? banco;
  String? agencia;
  String? conta;
  String? picPay;

  List<Foto> fotos;

  Ong(
      {required this.nome,
      required this.email,
      required this.senha,
      required this.descricao,
      required this.endereco,
      required this.tipo,
      required this.telefone,
      required this.latitude,
      required this.longitude,
      required this.avaliacao,
      required this.avaliacaoTotal,
      required this.qtdAvaliacao,
      this.site,
      this.chavePix,
      this.banco,
      this.agencia,
      this.conta,
      this.picPay,
      required this.fotos});
}
