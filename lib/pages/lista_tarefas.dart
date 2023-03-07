import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador/model/tarefa.dart';

class ListaTarefa extends StatefulWidget {
  @override
  _ListaTarefasState createState() => _ListaTarefasState();

}

class _ListaTarefasState extends State<ListaTarefa> {
  final tarefas = <Tarefa>[
    Tarefa(
        id: 1,
        descricao: 'Fazer atividades da aula',
        prazo: DateTime.now().add(Duration(days: 5))
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'New Task',
        child: Icon(Icons.add),
      ),
    );
  }


  AppBar _criarAppBar() {
    return AppBar(
      title: const Text('Gerenciador de Tarefas'),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list)),
      ],
    );
  }

  Widget _criarBody() {
    if (tarefas.isEmpty) {
      return const Center(
        child: Text('Não existe nenhuma tarefa cadastrada!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.separated(
      itemCount: tarefas.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        final tarefa = tarefas[index];
        return ListTile(
          title: Text('${tarefa.id} - ${tarefa.descricao}'),
          subtitle: Text('Prazo - ${tarefa.prazo}'),
        );
      },
    );
  }
}