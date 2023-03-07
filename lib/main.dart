import 'package:flutter/material.dart';
import 'package:gerenciador/pages/lista_tarefas.dart';

void main() {
  runApp(const AppGerenciadorTareas());
}

class AppGerenciadorTareas extends StatelessWidget {
  const AppGerenciadorTareas({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.lightGreen,
      ),
      home: ListaTarefa(),
    );
  }
}