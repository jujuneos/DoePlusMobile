import 'package:doeplus/controllers/login_controller.dart';
import 'package:doeplus/controllers/ongs_controller.dart';
import 'package:doeplus/styles/tema/default_theme.dart';
import 'package:doeplus/views/inicio_view.dart';
import 'package:doeplus/views/inicio_view_logado.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

GlobalKey globalKey = GlobalKey();

class TelaBusca extends StatelessWidget {
  const TelaBusca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OngsController());
    controller.context = context;

    if (controller.ongs.isEmpty) {
      Loader.show(context,
          progressIndicator:
              CircularProgressIndicator(color: DefaultTheme.getColor()));
    }

    controller.loadOngs();

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (tokenGlobal != null) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InicioViewLogado()));
                } else {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InicioView()));
                }
              },
              icon: const Icon(Icons.arrow_back)),
          title: Row(children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(80, 10, 2, 10),
                child: SizedBox(
                    height: 25,
                    child: Image.asset("assets/images/doeplus-logo.png"))),
            const Padding(
                padding: EdgeInsets.fromLTRB(2, 10, 50, 10),
                child: Text("Buscar",
                    style: TextStyle(
                        color: Color.fromRGBO(204, 14, 221, 10),
                        fontFamily: "HammersmithOne",
                        fontSize: 20)))
          ]),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                                    controller.removerFiltro();
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
              height: 800,
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
