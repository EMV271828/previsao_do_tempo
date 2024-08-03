import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'env/env_variables.dart';
import 'widgets_customizados/cartao_tempo.dart';

class AppBody extends StatefulWidget {
  final Function atualizar;
  final Map<String, dynamic> valoresDoMain;

  const AppBody(this.atualizar, this.valoresDoMain, {super.key});

  @override
  State<StatefulWidget> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  Future<Map<String, dynamic>> _obterQualidadeDoAr(coordenadas) async {
    Map<String, dynamic> dados = {};
    var tempoAtual = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    String urlQualidadeDoAr =
        "https://api.openweathermap.org/data/2.5/air_pollution/history?"
        "lat=${coordenadas[0]}&lon=${coordenadas[1]}&start=${tempoAtual - 20000}"
        "&end=$tempoAtual&appid=$apiKey";

    http.Response busca = await http.get(Uri.parse(urlQualidadeDoAr));

    var resposta = jsonDecode(busca.body)['list'][0];

    dados['qualidade'] = resposta['main']['aqi'];
    dados['co'] = resposta['components']['co'] ?? 'indisponível';
    dados['no2'] = resposta['components']['no2'] ?? 'indisponível';
    dados['so2'] = resposta['components']['so2'] ?? 'indisponível';
    dados['o3'] = resposta['components']['o3'] ?? 'indisponível';
    dados['pm2_5'] = resposta['components']['pm2_5'] ?? 'indisponível';
    dados['pm10'] = resposta['components']['pm10'] ?? 'indisponível';

    return dados;
  }

  Future<List> _obterDadosClima(coordenadas) async {
    Map<String, List<List>> dados = {};

    String urlPrevisaoTempo =
        "https://api.openweathermap.org/data/2.5/forecast?"
        "lat=${coordenadas[0]}&lon=${coordenadas[1]}&appid=$apiKey&units=metric";

    http.Response busca = await http.get(Uri.parse(urlPrevisaoTempo));

    var resposta = jsonDecode(busca.body)['list'];

    for (var x in resposta) {
      if (!dados.containsKey(x['dt_txt'].split(' ')[0])) {
        dados[x['dt_txt'].split(' ')[0]] = [
          [
            x['main']['temp'],
            x['main']['temp_max'],
            x['main']['temp_min'],
            x['weather'][0]['description'],
            DateTime.parse(x['dt_txt'])
          ]
        ];
      } else {
        dados[x['dt_txt'].split(' ')[0]]?.add([
          x['main']['temp'],
          x['main']['temp_max'],
          x['main']['temp_min'],
          x['weather'][0]['description'],
          DateTime.parse(x['dt_txt'])
        ]);
      }
    }

    List lista = [];
    for (String x in dados.keys) {
      lista.add(dados[x]);
    }

    return lista;
  }

  dynamic _obterDados() async {
    if (_localizacaoController.text == "") return "empty";

    String urlCidade = "https://api.openweathermap.org/geo/1.0/direct?q="
        "${_localizacaoController.text}&limit=1&appid=$apiKey";

    http.Response busca = await http.get(Uri.parse(urlCidade));

    var val = jsonDecode(busca.body);

    if (val.isEmpty) return "not found";

    widget.valoresDoMain['titulo'] = val[0]['local_names']?['pt'] == null
        ? 'Previsões para ${val[0]['name']}, ${val[0]['country']}'
        : 'Previsões para ${val[0]['local_names']['pt']} , ${val[0]['country']}';
    widget.atualizar();

    List coordenadas = [
      val[0]['lat'].toStringAsFixed(2),
      val[0]['lon'].toStringAsFixed(2)
    ];

    _dadosClima = _obterDadosClima(coordenadas);
    _dadosQualidadeDoAr = _obterQualidadeDoAr(coordenadas);
  }

  Future<List>? _dadosClima;
  Future<Map>? _dadosQualidadeDoAr;
  bool desativarBusca = false;

  final TextEditingController _localizacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 350,
          child: TextField(
            controller: _localizacaoController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Digite uma cidade',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        ),
        ElevatedButton(
            onPressed: desativarBusca
                ? null
                : () async {
                    desativarBusca = true;
                    setState(() {});

                    var resultado = await _obterDados();

                    if (resultado == "empty" && context.mounted) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: const Icon(Icons.error_outline,
                                  color: Colors.red, size: 40),
                              title: const Text(
                                "Erro!",
                                textAlign: TextAlign.justify,
                              ),
                              content: const Text("Campo em branco"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Sair'),
                                  child: const Text('Sair'),
                                ),
                              ],
                            );
                          });
                    } else if (resultado == "not found" && context.mounted) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: const Icon(Icons.error_outline,
                                  color: Colors.red, size: 40),
                              title: const Text(
                                "Erro!",
                                textAlign: TextAlign.justify,
                              ),
                              content: const Text("Cidade não encontrada"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Sair'),
                                  child: const Text('Sair'),
                                ),
                              ],
                            );
                          });
                    }
                    await Future.delayed(const Duration(seconds: 2), () {
                      desativarBusca = false;
                      setState(() {});
                    });
                  },
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: const Text("Obter previsão do tempo"),
            )),
        FutureBuilder(
            future: _dadosClima,
            builder: (builder, snapshot) {
              List<Widget> children = [];
              if (desativarBusca) {
                children = [const Center(child: CircularProgressIndicator())];
              } else if (snapshot.hasData) {
                children = [
                  for (int i = 0; i < snapshot.data!.length; i++)
                    CartaoTempo(snapshot.data?[i])
                ];
              }

              return Container(
                  width: double.infinity,
                  height: 400,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ListView(
                    children: children,
                  ));
            }),
        FutureBuilder(
            future: _dadosQualidadeDoAr,
            builder: (builder, snapshot) {
              Widget? value;
              if (desativarBusca) {
              } else if (snapshot.hasData) {
                value = TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/qualidadeAr",
                          arguments: snapshot.data);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      padding: const EdgeInsets.all(10),
                      width: 250,
                      color: Colors.blue,
                      child: const Text(
                        "Obter dados da qualidade do ar",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ));
              }

              return Center(
                child: value,
              );
            })
      ],
    ));
  }
}
