// ignore: file_names
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:doeplus/views/inicio_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return const SplashScreenView();
  }
}

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  Future delay(context) async {
    await Future.delayed(const Duration(milliseconds: 1500)).then((_) => {
          Navigator.push(
            context,
            PageTransition(
              child: const InicioView(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 800),
            ),
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    delay(context);
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(children: [
          const SizedBox(height: 82),
          const Text('Doe+',
              style: TextStyle(
                  color: Color.fromRGBO(204, 14, 221, 10),
                  fontFamily: 'HammersmithOne',
                  fontSize: 96,
                  fontWeight: FontWeight.w400)),
          SizedBox(
              height: 280,
              child: Image.asset("assets/images/doeplus-logo.png",
                  fit: BoxFit.cover)),
        ]),
      )),
    );
  }
}
