// ignore: file_names
import 'dart:convert';

import 'package:doeplus/controllers/CadastroOngController.dart';
import 'package:doeplus/styles/fontes/fontDefaultStyles.dart';
import 'package:doeplus/styles/tema/defaultTheme.dart';
import 'package:doeplus/utils/EnderecoJson.dart';
import 'package:doeplus/utils/maskUtils.dart';
import 'package:doeplus/viewModels/cadastroViewModel.dart';
import 'package:flutter/material.dart';
import 'package:doeplus/views/inicioView.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class CadastroOngView extends StatefulWidget {
  const CadastroOngView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CadastroOngView();
}

class _CadastroOngView extends State<CadastroOngView> {
  var model = CadastroViewModel();
  final controller = Get.put(CadastroOngController());
  String tipoOng = "Escolha o tipo";
  bool mostraSenha = false;
  List<XFile> fotos = [];

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<void> upload(XFile foto) async {
    fotos.add(foto);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
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
                body: Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Form(
                        key: controller.formKey,
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
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        labelText: 'Telefone'),
                                    inputFormatters: [
                                      MaskUtils.maskFormatterTelefone()
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
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        labelText: 'E-mail'),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return 'E-mail não informado!';
                                      }
                                      return null;
                                    },
                                  )),
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
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                    controller: controller.endereco,
                                    style: FontDefaultStyles.sm(),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        labelText: 'Endereço completo'),
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return 'Endereço não informado!';
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
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        labelText: 'Descrição'),
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return 'Informe uma breve descrição da instituição.';
                                      }
                                      return null;
                                    },
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(60, 15, 60, 15),
                                  child: TextFormField(
                                    controller: controller.chavePix,
                                    style: FontDefaultStyles.sm(),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 15, 20, 15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        labelText: 'Usuário do Picpay'),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(80, 0, 80, 10),
                                  child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      child: MaterialButton(
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 12, 15, 12),
                                          onPressed: enviarImagem,
                                          child: const Text("Adicionar imagem",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'HammersmithOne',
                                                  color: Color.fromRGBO(
                                                      204, 14, 221, 10),
                                                  fontSize: 20))))),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(80, 0, 80, 10),
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(20),
                                    color: DefaultTheme.getColor(),
                                    child: MaterialButton(
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 12, 15, 12),
                                        onPressed: () {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            salvarDados();
                                          }
                                          Navigator.pop(context);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const InicioView()));
                                        },
                                        child: const Text("Registrar",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'HammersmithOne',
                                                color: Colors.white,
                                                fontSize: 23))),
                                  ))
                            ])))))));
  }

  salvarDados() async {
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?address=${controller.endereco.text}&key=AIzaSyDl3y4dN1jwbSi6FQE11vzvXZk_l5ERlKA";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = EnderecoJson.fromJson(jsonDecode(response.body));

      var lat = json.results?[0].geometry?.bounds?.northeast?.lat;
      var lng = json.results?[0].geometry?.bounds?.northeast?.lng;

      controller.registrar(lat, lng, fotos);
    } else {
      throw 'Não foi possível encontrar o endereço informado.';
    }

    controller.limparDados();
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

  enviarImagem() async {
    XFile? file = await getImage();
    if (file != null) {
      controller.isLoading.value = true;
      await upload(file);
      controller.isLoading.value = false;
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
                          Navigator.pop(context, true);
                        },
                      )),
                ]);
          });
    } else {
      fotos = [];
    }
  }

  void visibilidadeSenha() {
    setState(() {
      mostraSenha = !mostraSenha;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
