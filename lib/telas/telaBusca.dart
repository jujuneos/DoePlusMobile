import 'package:doeplus/controllers/OngsController.dart';
import 'package:doeplus/views/inicioView.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

final appKey = GlobalKey();

class TelaBusca extends StatelessWidget {
  const TelaBusca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OngsController());

    return Scaffold(
      key: appKey,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
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
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text('Filtrar busca'),
                          children: [
                            Padding(
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
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextButton(
                                  child: const Text("Limpar filtro",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Arimo',
                                          fontSize: 15)),
                                  onPressed: () {
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
