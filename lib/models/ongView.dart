class OngView {
  String nome;
  String tipo;
  String descricao;
  String endereco;
  String foto;
  String telefone;
  double latitude;
  double longitude;
  String? chavePix;
  String? banco;
  String? agencia;
  String? conta;
  String? picPay;

  OngView(
      {required this.nome,
      required this.descricao,
      required this.endereco,
      required this.foto,
      required this.tipo,
      required this.telefone,
      required this.latitude,
      required this.longitude,
      this.chavePix,
      this.banco,
      this.agencia,
      this.conta,
      this.picPay});
}
