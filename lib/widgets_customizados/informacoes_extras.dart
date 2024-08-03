import 'package:flutter/material.dart';

class InformacoesExtras extends StatelessWidget {
  final List valoresClima;

  const InformacoesExtras(this.valoresClima, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(width: 2, color: Colors.white)),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(2),
              child: Text(
                'Previsão das ${valoresClima[4].hour}-${valoresClima[4].hour+3}'
                    ' horas',
                style: const TextStyle(color: Colors.white),
              )),
          Container(
            padding: const EdgeInsets.all(2),
            child: Text(
              'Temperatura: ${valoresClima[0]} °C',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                  child: Text(
                    'Max: ${valoresClima[1]} °C',
                    style: const TextStyle(color: Colors.white),
                  )),
              Container(
                  padding: EdgeInsets.all(2),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                  child: Text(
                    'Min: ${valoresClima[2]} °C',
                    style: const TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
