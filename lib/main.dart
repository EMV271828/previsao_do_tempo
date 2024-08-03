import 'package:flutter/material.dart';
import 'widgets_customizados/qualidade_do_ar.dart';
import 'app_body.dart';

void main() => runApp(AppPrevisaoDoTempo());

class AppPrevisaoDoTempo extends StatefulWidget {
  const AppPrevisaoDoTempo({super.key});

  @override
  State<StatefulWidget> createState() => _PrevisaoDoTempoState();
}

class _PrevisaoDoTempoState extends State<AppPrevisaoDoTempo> {
  atualizar() => setState(() {});

  Map<String, dynamic> valores = {'titulo':""};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {"/qualidadeAr":(context) => const QualidadeDoAr()},
      home: Scaffold(
        appBar: AppBar(title: Text(valores['titulo']),centerTitle: true,),
        body: AppBody(atualizar, valores),
      ),
    );
  }
}
