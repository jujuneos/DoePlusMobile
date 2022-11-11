import 'package:doeplus/controllers/login_controller.dart';
import 'package:doeplus/controllers/ongs_controller.dart';
import 'package:doeplus/models/ong_view.dart';
import 'package:doeplus/styles/fontes/font_default_styles.dart';
import 'package:doeplus/styles/tema/default_theme.dart';
import 'package:doeplus/utils/toast.dart';
import 'package:doeplus/views/login_view.dart';
import 'package:doeplus/views/pagina_ong_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
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
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
                itemPadding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5.0),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  avaliacao = rating;
                }),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Você pode escrever algo, se quiser.",
                  style: TextStyle(
                      color: Color.fromRGBO(204, 14, 221, 10),
                      fontFamily: 'HammersmithOne',
                      fontSize: 15),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
                child: TextFormField(
                  style: FontDefaultStyles.sm(),
                  maxLines: 5,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
              child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                  color: DefaultTheme.getColor(),
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                      onPressed: () {
                        globalLoginKey = GlobalKey();
                        if (userGlobal != null) {
                          Loader.show(context,
                              progressIndicator: CircularProgressIndicator(
                                  color: DefaultTheme.getColor()));
                          controller.avaliarOng(
                              ong, avaliacao, tokenGlobal!, context);
                        } else {
                          ToastGenerico.mostrarMensagemErro(
                              "É necessário fazer o login.");
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        }
                      },
                      child: const Text("Avaliar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'HammersmithOne',
                              color: Colors.white,
                              fontSize: 20)))),
            )
          ],
        ));
  }
}
