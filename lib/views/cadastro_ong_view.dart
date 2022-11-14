import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:doeplus/controllers/cadastro_ong_controller.dart';
import 'package:doeplus/models/foto.dart';
import 'package:doeplus/styles/fontes/font_default_styles.dart';
import 'package:doeplus/styles/tema/default_theme.dart';
import 'package:doeplus/utils/endereco_json.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/inicio_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:doeplus/utils/toast.dart';

GlobalKey globalOngKey = GlobalKey();

// ignore: must_be_immutable
class CadastroOngView extends StatefulWidget {
  const CadastroOngView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CadastroOngView();
}

class _CadastroOngView extends State<CadastroOngView> {
  final controller = Get.put(CadastroOngController());
  String tipoOng = "Escolha o tipo";
  bool mostraSenha = false;
  List<Foto> fotos = [];
  List<String> nomesFotos = [];

  String? tipoArquivo(String? nome) {
    String? mimeType = mime(nome);

    return mimeType;
  }

  getImage() async {
    var imagem;
    imagem = await ImagePicker().pickImage(source: ImageSource.gallery);

    String tipo = tipoArquivo(imagem.name) ?? "";

    Foto foto = Foto();
    foto.nome = imagem.name;
    foto.tipo = tipo;
    foto.path = imagem.path;

    fotos.add(foto);
    nomesFotos.add(foto.nome ?? "");

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: const Text(
                'Imagem adicionada com sucesso!',
                style: TextStyle(
                    color: Color.fromRGBO(204, 14, 221, 10),
                    fontFamily: 'HammersmithOne',
                    fontSize: 18),
              ),
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextButton(
                      child: const Text("Fechar",
                          style: TextStyle(
                              color: Color.fromRGBO(204, 14, 221, 10),
                              fontFamily: 'HammersmithOne',
                              fontSize: 15)),
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context, true);
                      },
                    )),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    globalOngKey = GlobalKey();
    return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InicioView()));
                        },
                        icon: const Icon(Icons.arrow_back)),
                    title: const Text("Doe+"),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme: const IconThemeData(
                        color: Color.fromRGBO(204, 14, 221, 10))),
                body: Form(
                    key: controller.cadastroKey,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          const Text("Cadastro de instituição",
                              style: TextStyle(
                                color: Color.fromRGBO(204, 14, 221, 10),
                                fontFamily: 'HammersmithOne',
                                fontSize: 24,
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.nome,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Nome da instituição'),
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Informe um nome!';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.telefone,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Telefone'),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  TelefoneInputFormatter()
                                ],
                                keyboardType: TextInputType.number,
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextButton(
                                onPressed: mostrarTipos,
                                child: Text(tipoOng,
                                    style: TextStyle(
                                        color: DefaultTheme.getColor(),
                                        fontFamily: 'HammersmithOne',
                                        fontSize: 15)),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.email,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Usuário para login'),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Informe um Usuário!';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(60, 15, 60, 1),
                            child: Text(
                                "A senha deve conter 8 ou mais caracteres, pelo menos uma letra maiúscula, um número e um caractere especial.",
                                style: FontDefaultStyles.sm_2()),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.senha,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                        onTap: visibilidadeSenha,
                                        child: Icon(mostraSenha
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Senha'),
                                obscureText:
                                    mostraSenha == false ? true : false,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Informe sua senha!';
                                  } else if (value.toString().length < 8) {
                                    return 'Sua senha deve ter no mínimo 8 caracteres';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                  controller: controller.site,
                                  style: FontDefaultStyles.sm(),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 15),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      labelText: 'Instagram ou site'))),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.endereco,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Endereço completo'),
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Informe um endereço válido!';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.descricao,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Descrição'),
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: Text(
                                "Preencha pelo menos um dos campos abaixo.",
                                style: FontDefaultStyles.sm(),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.chavePix,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Chave Pix'),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.banco,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Banco'),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.agencia,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Agência'),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.conta,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Conta bancária'),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: TextFormField(
                                controller: controller.picPay,
                                style: FontDefaultStyles.sm(),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    labelText: 'Usuário do Picpay'),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(60, 15, 60, 15),
                              child: nomesFotos.isNotEmpty
                                  ? Column(children: [
                                      for (var nome in nomesFotos)
                                        Text(nome,
                                            style: FontDefaultStyles.sm())
                                    ])
                                  : const Text("")),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(80, 0, 80, 10),
                              child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  child: MaterialButton(
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 12, 15, 12),
                                      onPressed: getImage,
                                      child: const Text("Adicionar imagem",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'HammersmithOne',
                                              color: Color.fromRGBO(
                                                  204, 14, 221, 10),
                                              fontSize: 20))))),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(80, 0, 80, 10),
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(20),
                                color: DefaultTheme.getColor(),
                                child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 12, 15, 12),
                                    onPressed: () {
                                      if (controller.cadastroKey.currentState!
                                          .validate()) {
                                        Loader.show(context,
                                            progressIndicator:
                                                CircularProgressIndicator(
                                                    color: DefaultTheme
                                                        .getColor()));
                                        salvarDados();
                                      }
                                    },
                                    child: const Text("Registrar",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'HammersmithOne',
                                            color: Colors.white,
                                            fontSize: 23))),
                              ))
                        ]))))));
  }

  salvarDados() async {
    String retorno = "";

    try {
      String url =
          "https://maps.googleapis.com/maps/api/geocode/json?address=${controller.endereco.text}&key=AIzaSyDl3y4dN1jwbSi6FQE11vzvXZk_l5ERlKA";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = EnderecoJson.fromJson(jsonDecode(response.body));

        var lat = json.results?[0].geometry?.location?.lat;
        var lng = json.results?[0].geometry?.location?.lng;

        controller.registrar(lat, lng, fotos, context);
      } else {
        retorno = "Endereço inválido.";
        ToastGenerico.mostrarMensagemErro(retorno);
      }
    } catch (e) {
      retorno = "Erro! Instituição não cadastrada.";
      ToastGenerico.mostrarMensagemErro(retorno);
    }

    //controller.limparDados();
  }

  Future mostrarTipos() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Escolha o tipo de ONG'),
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButton(
                    child: const Text("Saúde",
                        style: TextStyle(
                            color: Color.fromRGBO(204, 14, 221, 10),
                            fontFamily: 'Arimo',
                            fontSize: 15)),
                    onPressed: () {
                      setState(() {});
                      tipoOng = "Saúde";
                      controller.tipo.text = tipoOng;
                      Navigator.pop(context, true);
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButton(
                    child: const Text("LGBTQIA+",
                        style: TextStyle(
                            color: Color.fromRGBO(204, 14, 221, 10),
                            fontFamily: 'Arimo',
                            fontSize: 15)),
                    onPressed: () {
                      setState(() {});
                      tipoOng = "LGBTQIA+";
                      controller.tipo.text = tipoOng;
                      Navigator.pop(context, true);
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButton(
                    child: const Text("Animais",
                        style: TextStyle(
                            color: Color.fromRGBO(204, 14, 221, 10),
                            fontFamily: 'Arimo',
                            fontSize: 15)),
                    onPressed: () {
                      setState(() {});
                      tipoOng = "Animais";
                      controller.tipo.text = tipoOng;
                      Navigator.pop(context, true);
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButton(
                    child: const Text("Famílias carentes",
                        style: TextStyle(
                            color: Color.fromRGBO(204, 14, 221, 10),
                            fontFamily: 'Arimo',
                            fontSize: 15)),
                    onPressed: () {
                      setState(() {});
                      tipoOng = "Famílias";
                      controller.tipo.text = tipoOng;
                      Navigator.pop(context, true);
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButton(
                    child: const Text("Fechar",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Arimo',
                            fontSize: 15)),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  )),
            ],
          );
        });
  }

  void visibilidadeSenha() {
    setState(() {
      mostraSenha = !mostraSenha;
    });
  }
}
