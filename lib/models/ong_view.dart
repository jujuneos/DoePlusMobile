class OngView {
  String? id;
  String? nome;
  String? tipo;
  String? descricao;
  String? endereco;
  String? foto;
  String? telefone;
  double? latitude;
  double? longitude;
  double? avaliacao;
  String? site;
  String? chavePix;
  String? banco;
  String? agencia;
  String? conta;
  String? picPay;
  List<dynamic>? fotos;

  OngView(
      {this.id,
      this.nome,
      this.descricao,
      this.endereco,
      this.foto,
      this.tipo,
      this.telefone,
      this.latitude,
      this.longitude,
      this.fotos,
      this.avaliacao,
      this.site,
      this.chavePix,
      this.banco,
      this.agencia,
      this.conta,
      this.picPay});
}
