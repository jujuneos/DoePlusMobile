import 'dart:async';
import 'dart:convert';

import 'package:doeplus/models/ongView.dart';
import 'package:doeplus/models/usuarioLogin.dart';
import 'package:doeplus/telas/telaBusca.dart';
import 'package:doeplus/views/widgets/ongInfo.dart';
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
  var url = "https://doeplusapi.herokuapp.com/api/";

  get mapsController => _mapsController;

  avaliarOng(OngView ong, double avaliacao, String token) async {
    var urlAvaliacao = url + 'Instituicoes/Avaliar/${ong.id}';

    var response = await http.post(Uri.parse(urlAvaliacao),
        body: jsonEncode({"avaliacao": avaliacao}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    return response;
  }

  favoritar(OngView ong, String token) async {
    var urlFavoritar = url + 'Usuarios/favoritar/${ong.id}';

    var response = await http.post(Uri.parse(urlFavoritar), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });

    return response;
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
            markerId: MarkerId(ong.nome),
            position: LatLng(ong.latitude, ong.longitude),
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
    var urlGeral = url + "Instituicoes";
    var urlFoto = url + "Fotos/Foto/";
    var urlFotos = url + "Fotos/Fotos/";

    try {
      final response = await http.get(Uri.parse(urlGeral));

      var dados = jsonDecode(response.body);

      for (var dado in dados) {
        final foto = await http.get(Uri.parse(urlFoto + dado['id']));
        final responseFotos = await http.get(Uri.parse(urlFotos + dado['id']));

        var dadosFoto = jsonDecode(foto.body);
        var fotos = jsonDecode(responseFotos.body);

        ongs.add(OngView(
            id: dado['id'],
            nome: dado['userName'],
            tipo: dado['tipo'],
            descricao: dado['descricao'],
            foto: dadosFoto['bytes'],
            fotos: fotos,
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
            picPay: dado['picPay'] ?? ""));
      }

      Loader.hide();
    } catch (error) {
      rethrow;
    }

    markers.clear();

    for (var ong in ongs) {
      markers.add(
        Marker(
            markerId: MarkerId(ong.nome),
            position: LatLng(ong.latitude, ong.longitude),
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
