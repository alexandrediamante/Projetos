// ignore_for_file: unused_import, prefer_final_fields, no_leading_underscores_for_local_identifiers
//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //String _resultado = "";
  TextEditingController _controllerCep = TextEditingController();
  String _logradouro = "";
  String _complemento = "";
  String _bairro = "";
  String _localidade = "";
  String _uf = "";

  void _recuperarCep() async {
    String _cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${_cepDigitado}/json/";

    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);

    _logradouro = retorno["logradouro"];
    _complemento = retorno["complemento"];
    _bairro = retorno["bairro"];
    _localidade = retorno["localidade"];
    _uf = retorno["uf"];

    setState(() {});

    _limparCampos();
  }

  void _limparCampos() {
    _controllerCep.text = "";
  }

  Widget _buildAddressText(String? label, String? value) {
    return Text(
      label == '' ? '' : "$label $value",
      style: TextStyle(fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text("Busca CEP"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Image.asset(
                  "images/logo.png",
                  height: 225,
                  width: 225,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 75, right: 75, bottom: 25),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Digite o CEP (somente números):",
                  ),
                  style: TextStyle(fontSize: 20),
                  controller: _controllerCep,
                ),
              ),
              MaterialButton(
                color: Colors.amberAccent,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Text(
                  "Buscar",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: _recuperarCep,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _logradouro == ""
                        ? _buildAddressText("", '')
                        : _buildAddressText("Logradouro:", _logradouro),
                    _complemento == ""
                        ? _buildAddressText("", '')
                        : _buildAddressText("Complemento:", _complemento),
                    _bairro == ""
                        ? _buildAddressText("", '')
                        : _buildAddressText("Bairro:", _bairro),
                    _localidade == ""
                        ? _buildAddressText("", '')
                        : _buildAddressText("Localidade:", _localidade),
                    _uf == ""
                        ? _buildAddressText("", '')
                        : _buildAddressText("UF:", _uf),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
