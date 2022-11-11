class OngView {
  String id;
  String nome;
  String tipo;
  String descricao;
  String endereco;
  String foto;
  String telefone;
  double latitude;
  double longitude;
  double avaliacao;
  String? site;
  String? chavePix;
  String? banco;
  String? agencia;
  String? conta;
  String? picPay;
  List<dynamic> fotos;

  OngView(
      {required this.id,
      required this.nome,
      required this.descricao,
      required this.endereco,
      required this.foto,
      required this.tipo,
      required this.telefone,
      required this.latitude,
      required this.longitude,
      required this.fotos,
      required this.avaliacao,
      this.site,
      this.chavePix,
      this.banco,
      this.agencia,
      this.conta,
      this.picPay});
}
