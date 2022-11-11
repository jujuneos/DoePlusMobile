import 'package:doeplus/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/login_view.dart';

class EntraBotao extends StatefulWidget {
  const EntraBotao({Key? key}) : super(key: key);

  @override
  State<EntraBotao> createState() => _EntraBotaoState();
}

class _EntraBotaoState extends State<EntraBotao> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(244, 244, 244, 10),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
            onPressed: () {
              loginKey = GlobalKey();
              globalLoginKey = GlobalKey();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginView()));
            },
            child: const Text("Entrar",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'HammersmithOne',
                    color: Color.fromRGBO(204, 14, 221, 10),
                    fontSize: 25)),
          ),
        ));
  }
}
