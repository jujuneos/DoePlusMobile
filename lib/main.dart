import 'package:doeplus/services/AutenticacaoService.dart';
import 'package:doeplus/telas/telaInicial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<AutenticacaoService>(() => AutenticacaoService());
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Doe Plus',
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
                    .copyWith(secondary: Colors.deepPurple)),
        home: const TelaInicial());
  }
}
