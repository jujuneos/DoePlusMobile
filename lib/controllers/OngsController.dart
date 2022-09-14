import 'dart:async';
import 'dart:convert';

import 'package:doeplus/models/ong.dart';
import 'package:doeplus/models/ongView.dart';
import 'package:doeplus/telas/telaBusca.dart';
import 'package:doeplus/views/widgets/ongInfo.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class OngsController extends GetxController {
  double latitude = 0.0;
  double longitude = 0.0;
  String erro = '';
  Set<Marker> markers = <Marker>{};
  late GoogleMapController _mapsController;
  late StreamSubscription<Position> positionStream;

  get mapsController => _mapsController;

  filtrarOngs(String tipo) async {
    List<OngView> ongs = [];
    var url = "https://doeplusapi.herokuapp.com/api/Instituicoes";

    try {
      final response = await http.get(Uri.parse(url));
      final dados = jsonDecode(response.body);

      for (var dado in dados) {
        ongs.add(OngView(
            nome: dado['nome'],
            tipo: dado['tipo'],
            descricao: dado['descricao'],
            endereco: dado['endereco'],
            foto: dado['foto'],
            telefone: dado['telefone'],
            latitude: dado['latitude'],
            longitude: dado['longitude'],
            chavePix: dado['chavePix'] ?? "",
            banco: dado['banco'] ?? "",
            agencia: dado['agencia'] ?? "",
            conta: dado['conta'] ?? "",
            picPay: dado['picPay'] ?? ""));
      }
    } catch (error) {
      rethrow;
    }

    List<dynamic> ongsFiltro = [];

    for (var element in ongs) {
      if (element.tipo == tipo) {
        ongsFiltro.add(element);
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
                    context: appKey.currentState!.context,
                    builder: (context) => OngInfo(ong: ong),
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
    List<dynamic> ongs = [];
    var url = "https://doeplusapi.herokuapp.com/api/Instituicoes";

    try {
      final response = await http.get(Uri.parse(url));

      final dados = jsonDecode(response.body);

      for (var dado in dados) {
        print(dado);
        ongs.add(OngView(
            nome: dado['nome'],
            tipo: dado['tipo'],
            descricao: dado['descricao'],
            endereco: dado['endereco'],
            foto: dado['foto'],
            telefone: dado['telefone'],
            latitude: dado['latitude'],
            longitude: dado['longitude'],
            chavePix: dado['chavePix'] ?? "",
            banco: dado['banco'] ?? "",
            agencia: dado['agencia'] ?? "",
            conta: dado['conta'] ?? "",
            picPay: dado['picPay'] ?? ""));
      }
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
                    context: appKey.currentState!.context,
                    builder: (context) => OngInfo(ong: ong),
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
