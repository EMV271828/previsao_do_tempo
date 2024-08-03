import 'package:flutter/material.dart';

class QualidadeDoAr extends StatelessWidget {
  static const Map qualidadeDoAr = {
    1: 'Ótima',
    2: 'Boa',
    3: 'Moderada',
    4: 'Ruim',
    5: 'Muito Ruim',
  };

  const QualidadeDoAr({super.key});

  @override
  Widget build(BuildContext context) {
    final dados =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Qualidade Do Ar'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        children: [
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              color: Colors.blue,
              child: Center(
                  child: Text(
                'Qualidade do ar: ${qualidadeDoAr[dados['qualidade']]}',
                style: const TextStyle(color: Colors.white),
              ))),
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 5),
              color: Colors.blue,
              child: const Center(
                  child: Text(
                'Concentrações de poluentes',
                style: const TextStyle(color: Colors.white),
              ))),
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              color: Colors.blue,
              child: Center(
                  child: Text(
                'CO: ${dados['co']} μg/m',
                style: const TextStyle(color: Colors.white),
              ))),
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              color: Colors.blue,
              child: Center(
                  child: Text(
                'NO2: ${dados['no2']} μg/m³',
                style: const TextStyle(color: Colors.white),
              ))),
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              color: Colors.blue,
              child: Center(
                  child: Text(
                'SO2: ${dados['so2']} μg/m³',
                style: const TextStyle(color: Colors.white),
              ))),
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              color: Colors.blue,
              child: Center(
                  child: Text(
                'NO2: ${dados['no2']} μg/m³',
                style: const TextStyle(color: Colors.white),
              ))),
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              color: Colors.blue,
              child: Center(
                  child: Text(
                'O3: ${dados['o3']} μg/m³',
                style: const TextStyle(color: Colors.white),
              ))),
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 5),
              color: Colors.blue,
              child: const Center(
                  child: Text(
                'Concentrações de particulados',
                style: const TextStyle(color: Colors.white),
              ))),
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              color: Colors.blue,
              child: Center(
                  child: Text(
                ' PM2.5: ${dados['pm2_5']} μg/m³',
                style: const TextStyle(color: Colors.white),
              ))),
          Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              color: Colors.blue,
              child: Center(
                  child: Text(
                'PM10: ${dados['pm10']} μg/m³',
                style: const TextStyle(color: Colors.white),
              ))),
        ],
      ),
    );
  }
}
