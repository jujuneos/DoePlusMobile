// ignore: file_names
import 'package:flutter/material.dart';

class TelaFormulario extends StatefulWidget {
  const TelaFormulario({Key? key}) : super(key: key);

  @override
  _TelaFormularioState createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Instituição'),
      ),
      body: const Center(
        child: Text('Form'),
      ),
    );
  }
}
