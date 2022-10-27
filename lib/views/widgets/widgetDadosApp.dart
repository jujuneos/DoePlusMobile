// ignore: file_names
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/telas/telaBusca.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DadosApp extends StatefulWidget {
  const DadosApp({Key? key}) : super(key: key);

  @override
  State<DadosApp> createState() => _DadosAppState();
}

class _DadosAppState extends State<DadosApp> {
  final email = 'mailto:luiz.conceicao@dcomp.ufs.br';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ExpansionTile(
          leading: Icon(Icons.info_outlined, color: DefaultTheme.getColor()),
          title: const Text('Informações',
              style: TextStyle(
                  color: Color.fromRGBO(204, 14, 221, 10),
                  fontFamily: 'Arimo',
                  fontSize: 15)),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextButton.icon(
                        onPressed: () {
                          globalKey = GlobalKey();
                          _launchURL(Uri.parse(email));
                        },
                        icon: const Icon(FontAwesomeIcons.envelope),
                        label: const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text("luiz.conceicao@dcomp.ufs.br"))))
              ],
            )
          ],
        ));
  }

  void _launchURL(var url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Não foi possível ir até $url');
    }
  }
}
