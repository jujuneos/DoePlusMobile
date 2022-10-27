import 'package:doeplus/controllers/OngsController.dart';
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/views/inicioView.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

const buscaKey1 = Key('chave1');
const buscaKey2 = Key('chave2');
const buscaKey3 = Key('chave3');
const buscaKey4 = Key('chave4');
const buscaKey5 = Key('chave5');
const buscaKey6 = Key('chave6');
const buscaKey7 = Key('chave7');
const buscaKey8 = Key('chave8');
GlobalKey globalKey = GlobalKey();

class TelaBusca extends StatelessWidget {
  const TelaBusca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OngsController());

    if (controller.ongs.isEmpty) {
      Loader.show(context,
          progressIndicator:
              CircularProgressIndicator(color: DefaultTheme.getColor()));
    }

    return Scaffold(
      key: buscaKey1,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                globalKey = GlobalKey();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InicioView()));
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Buscar ONGs',
              style: TextStyle(color: Color.fromRGBO(204, 14, 221, 10))),
          actions: [
            IconButton(
                key: buscaKey2,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          key: buscaKey3,
                          title: const Text('Filtrar busca'),
                          children: [
                            Padding(
                                key: buscaKey4,
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  child: const Text("ONGs destinadas à saúde",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(204, 14, 221, 10),
                                          fontFamily: 'Arimo',
                                          fontSize: 15)),
                                  onPressed: () {
                                    controller.filtrarOngs('Saúde');
                                    Navigator.pop(context, true);
                                  },
                                )),
                            Padding(
                                key: buscaKey5,
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  child: const Text(
                                      "ONGs para a comunidade LGBTQIA+",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(204, 14, 221, 10),
                                          fontFamily: 'Arimo',
                                          fontSize: 15)),
                                  onPressed: () {
                                    controller.filtrarOngs('LGBTQIA+');
                                    Navigator.pop(context, true);
                                  },
                                )),
                            Padding(
                                key: buscaKey6,
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  child: const Text("ONGs para animais",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(204, 14, 221, 10),
                                          fontFamily: 'Arimo',
                                          fontSize: 15)),
                                  onPressed: () {
                                    controller.filtrarOngs('Animais');
                                    Navigator.pop(context, true);
                                  },
                                )),
                            Padding(
                                key: buscaKey7,
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  child: const Text(
                                      "ONGs para famílias carentes",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(204, 14, 221, 10),
                                          fontFamily: 'Arimo',
                                          fontSize: 15)),
                                  onPressed: () {
                                    controller.filtrarOngs('Famílias');
                                    Navigator.pop(context, true);
                                  },
                                )),
                            Padding(
                                key: buscaKey8,
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  child: const Text("Limpar filtro",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Arimo',
                                          fontSize: 15)),
                                  onPressed: () {
                                    globalKey = GlobalKey();
                                    controller.loadOngs();
                                    Navigator.pop(context, true);
                                  },
                                )),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.filter_list))
          ],
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(204, 14, 221, 10))),
      body: GetBuilder<OngsController>(
          key: globalKey,
          init: controller,
          builder: (context) {
            return Container(
              height: 600,
              width: 800,
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, left: 16, right: 16),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(controller.latitude, controller.longitude),
                  zoom: 18,
                ),
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                myLocationEnabled: true,
                onMapCreated: controller.onMapCreated,
                markers: controller.markers,
              ),
            );
          }),
    );
  }
}
