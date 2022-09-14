class Ong {
  String nome;
  String email;
  String senha;
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

  Ong(
      {required this.nome,
      required this.email,
      required this.senha,
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
