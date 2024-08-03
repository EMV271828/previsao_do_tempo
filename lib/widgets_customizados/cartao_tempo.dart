import 'package:flutter/material.dart';
import 'informacoes_extras.dart';

class CartaoTempo extends StatefulWidget {
  final List<List> valoresClima;

  static const Map diasDaSemana = {
    1: 'Segunda-feira',
    2: 'Terça-feira',
    3: 'Quarta-feira',
    4: 'Quinta-feira',
    5: 'Sexta-feira',
    6: 'Sábado',
    7: 'Domingo',
  };

  const CartaoTempo(this.valoresClima, {super.key});

  _obterData(int index) {
    int dia = valoresClima[index][4].day;

    var diaDaSemana = DateTime.now().day == valoresClima[index][4].day
        ? 'Hoje,'
        : '${diasDaSemana[valoresClima[index][4].weekday]}, dia $dia,';

    int horas = valoresClima[index][4].hour ;

    return '$diaDaSemana $horas-${horas+3} horas';
  }

  _obterDataSimplificada() {
    return '${valoresClima[0][4].day}/${valoresClima[0][4].month}/${valoresClima[0][4].year}';
  }

  @override
  State<StatefulWidget> createState() => _CartaoTempoState();
}

class _CartaoTempoState extends State<CartaoTempo> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          widget.valoresClima.length == 1
              ? null
              : await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title:Container(
                        color: Colors.blue,
                        width: double.infinity,
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          'Previsões para ${widget._obterDataSimplificada()}',
                          style: const TextStyle(color: Colors.white),
                        )
                      ),
                      content: Column(children: [
                        for (int i = 1; i < widget.valoresClima.length; i++)
                          InformacoesExtras(widget.valoresClima[i])
                      ]),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Sair'),
                          child: const Text('Sair'),
                        ),
                      ],
                    );
                  });
        },
        child: Container(
          width: double.infinity,
          color: Colors.blue,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Text('${widget._obterData(0)}',
                      style: const TextStyle(color: Colors.white))),
              Container(
                child: Text('Temperatura: ${widget.valoresClima[0][0]} °C',
                    style: const TextStyle(color: Colors.white)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text('Max: ${widget.valoresClima[0][1]} °C',
                          style: const TextStyle(color: Colors.white))),
                  Container(
                      child: Text('Min: ${widget.valoresClima[0][2]} °C',
                          style: const TextStyle(color: Colors.white))),
                ],
              )
            ],
          ),
        ));
  }
}
