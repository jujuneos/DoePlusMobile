import 'dart:async';
import 'dart:convert';

import 'package:doeplus/models/ong_view.dart';
import 'package:doeplus/telas/tela_busca.dart';
import 'package:doeplus/utils/toast.dart';
import 'package:doeplus/views/ongs_favoritas_view.dart';
import 'package:doeplus/views/pagina_ong_view.dart';
import 'package:doeplus/views/widgets/ong_info.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class OngsController extends GetxController {
  double latitude = 0.0;
  double longitude = 0.0;
  String erro = '';
  Set<Marker> markers = <Marker>{};
  late GoogleMapController _mapsController;
  late StreamSubscription<Position> positionStream;
  List<OngView> ongs = [];
  List<OngView> ongsFavoritas = [];
  var url = "https://doeplusapi.herokuapp.com/";
  late BuildContext context;
  late double avaliacao;
  final avalia = TextEditingController();

  get mapsController => _mapsController;

  avaliarOng(
      OngView ong, double avaliacao, String token, BuildContext context) async {
    var urlAvaliacao = url + 'api/Instituicoes/Avaliar/${ong.id}/$avaliacao';

    print(avaliacao);

    var response = await http.post(Uri.parse(urlAvaliacao), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    if (response.statusCode == 200) {
      ToastGenerico.mostrarMensagemSucesso("Avaliação enviada com sucesso!");
      var dadosOng = url + 'api/Instituicoes/Obter/${ong.id}';
      var responseOng = await http.get(Uri.parse(dadosOng));
      var dado = jsonDecode(responseOng.body);

      var ongAtualizada = OngView(
          id: dado['id'],
          nome: dado['userName'],
          tipo: dado['tipo'],
          descricao: dado['descricao'],
          foto: ong.foto,
          fotos: ong.fotos,
          endereco: dado['endereco'],
          telefone: dado['phoneNumber'],
          latitude: dado['latitude'],
          longitude: dado['longitude'],
          site: dado['site'] ?? "",
          avaliacao: double.parse(dado['avaliacao'].toString()),
          chavePix: dado['chavePix'] ?? "",
          banco: dado['banco'] ?? "",
          agencia: dado['agencia'] ?? "",
          conta: dado['conta'] ?? "",
          picPay: dado['picPay'] ?? "");
      Loader.hide();
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PaginaOngView(ong: ongAtualizada).build(context)));
    } else {
      Loader.hide();
      ToastGenerico.mostrarMensagemErro("Erro! Avaliação não enviada.");
    }
  }

  favoritar(OngView ong, String token) async {
    var urlFavoritar = url + 'Usuarios/favoritar/${ong.id}';

    var response = await http.post(Uri.parse(urlFavoritar), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    if (response.statusCode == 200) {
      Loader.hide();
      ToastGenerico.mostrarMensagemSucesso("ONG adicionada às suas favoritas.");
    } else {
      Loader.hide();
      ToastGenerico.mostrarMensagemErro("ONG já favoritada.");
    }
  }

  favoritas(String token, BuildContext context) async {
    var urlFavoritas = url + 'Usuarios/favoritas';

    ongsFavoritas = [];

    final response = await http.get(Uri.parse(urlFavoritas), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    var dados = jsonDecode(response.body);

    for (var dado in dados) {
      ongsFavoritas.add(OngView(id: dado["id"], nome: dado["nome"]));
    }

    Loader.hide();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const OngsFavoritasView()));
  }

  filtrarOngs(String tipo) async {
    List<OngView> ongsFiltro = [];

    for (var ong in ongs) {
      if (ong.tipo == tipo) {
        ongsFiltro.add(ong);
      }
    }

    markers.clear();

    for (var ong in ongsFiltro) {
      markers.add(
        Marker(
            markerId: MarkerId(ong.nome!),
            position: LatLng(ong.latitude!, ong.longitude!),
            onTap: () => {
                  showModalBottomSheet(
                    context: globalKey.currentState!.context,
                    builder: (context) => OngInfo(ong: ong).build(context),
                  )
                }),
      );
    }
    update();
  }

  removerFiltro() async {
    markers.clear();

    for (var ong in ongs) {
      markers.add(
        Marker(
            markerId: MarkerId(ong.nome!),
            position: LatLng(ong.latitude!, ong.longitude!),
            onTap: () => {
                  showModalBottomSheet(
                    context: globalKey.currentState!.context,
                    builder: (context) => OngInfo(ong: ong).build(context),
                  )
                }),
      );
    }
    update();
  }

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosicao();
    loadOngs();
  }

  loadOngs() async {
    var urlGeral = url + "api/Instituicoes/marcadores";
    var urlFoto = url + "api/Fotos/Foto/";

    ongs = [];
    final response = await http.get(Uri.parse(urlGeral));
    var dados = jsonDecode(response.body);

    try {
      for (var dado in dados) {
        final foto = await http.get(Uri.parse(urlFoto + dado['id']));

        var dadosFoto = jsonDecode(foto.body);

        ongs.add(OngView(
            id: dado['id'],
            nome: dado['userName'],
            foto: dadosFoto['bytes'],
            latitude: dado['latitude'],
            longitude: dado['longitude'],
            endereco: dado['endereco'],
            tipo: dado['tipo']));
      }
      Loader.hide();
    } catch (error) {
      Loader.hide();
      ToastGenerico.mostrarMensagemErro("Erro! Tente novamente.");
    }

    markers.clear();

    for (var ong in ongs) {
      markers.add(
        Marker(
            markerId: MarkerId(ong.nome!),
            position: LatLng(ong.latitude!, ong.longitude!),
            onTap: () => {
                  showModalBottomSheet(
                      context: globalKey.currentState!.context,
                      builder: (context) => OngInfo(ong: ong).build(context))
                }),
      );
    }
    update();
  }

  loadDados(OngView ong, BuildContext context) async {
    var urlDados = url + "api/Instituicoes/dados/";
    var urlFinal = urlDados + ong.id!;
    var urlFotos = url + "api/Fotos/Fotos/";

    final response = await http.get(Uri.parse(urlFinal));

    try {
      final responseFotos = await http.get(Uri.parse(urlFotos + ong.id!));
      var fotos = jsonDecode(responseFotos.body);

      var dados = jsonDecode(response.body);
      ong.tipo = dados['tipo'];
      ong.descricao = dados['descricao'];
      ong.fotos = fotos;
      ong.telefone = dados['phoneNumber'];
      ong.site = dados['site'] ?? "";
      ong.avaliacao = double.parse(dados['avaliacao'].toString());
      ong.chavePix = dados['chavePix'] ?? "";
      ong.banco = dados['banco'] ?? "";
      ong.agencia = dados['agencia'] ?? "";
      ong.conta = dados['conta'] ?? "";
      ong.chavePix = dados['chavePix'] ?? "";

      Loader.hide();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PaginaOngView(ong: ong)));
    } catch (e) {
      Loader.hide();
      ToastGenerico.mostrarMensagemErro("Erro! Tente novamente mais tarde");
    }
  }

  watchPosicao() async {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  @override
  void onClose() {
    positionStream.cancel();
    super.onClose();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      latitude = posicao.latitude;
      longitude = posicao.longitude;
      _mapsController
          .animateCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));
    } catch (e) {
      erro = e.toString();
    }

    update();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;

    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone.');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização.');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
