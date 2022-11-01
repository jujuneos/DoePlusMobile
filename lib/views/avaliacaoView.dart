import 'package:doeplus/controllers/LoginController.dart';
import 'package:doeplus/controllers/OngsController.dart';
import 'package:doeplus/models/ongView.dart';
import 'package:doeplus/styles/fontes/fontDefaultStyles.dart';
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/telas/telaBusca.dart';
import 'package:doeplus/utils/toast.dart';
import 'package:doeplus/views/loginView.dart';
import 'package:doeplus/views/paginaOngView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

const avKey1 = Key("Avkey1");

class AvaliacaoView extends StatelessWidget {
  OngView ong;
  AvaliacaoView({Key? key, required this.ong}) : super(key: key);
  double avaliacao = 0.0;
  final controller = Get.put(OngsController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            key: avKey1,
            leading: IconButton(
                onPressed: () {
                  globalKey = GlobalKey();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaginaOngView(ong: ong)));
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
                  child: Text("Doe+",
                      style: TextStyle(
                          color: Color.fromRGBO(204, 14, 221, 10),
                          fontFamily: "HammersmithOne",
                          fontSize: 25)))
            ]),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme:
                const IconThemeData(color: Color.fromRGBO(204, 14, 221, 10))),
        body: Column(
          children: [
            RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  avaliacao = rating;
                }),
            Padding(
                padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
                child: TextFormField(
                  style: FontDefaultStyles.sm(),
                  maxLines: 5,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText:
                          'Você pode descrever sua experiência, se quiser.'),
                )),
            Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                color: DefaultTheme.getColor(),
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    onPressed: () {
                      globalKey = GlobalKey();
                      if (loginController.usuario != null) {
                        var response = controller.avaliarOng(ong, avaliacao,
                            loginController.usuario?.token ?? "");
                        if (response == 200) {
                          ToastGenerico.mostrarMensagemSucesso(
                              "Avaliação enviada com sucesso!");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PaginaOngView(ong: ong)));
                        } else {
                          ToastGenerico.mostrarMensagemErro(
                              "Erro! Avaliação não enviada.");
                        }
                      } else {
                        ToastGenerico.mostrarMensagemErro(
                            "É necessário fazer o login.");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()));
                      }
                    },
                    child: const Text("Selecionar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'HammersmithOne',
                            color: Colors.white,
                            fontSize: 20))))
          ],
        ));
  }
}
