import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador/model/tarefa.dart';

import 'form_new_task.dart';

class ListaTarefa extends StatefulWidget {
  @override
  _ListaTarefasState createState() => _ListaTarefasState();

}

class _ListaTarefasState extends State<ListaTarefa> {

  static const ACAO_EDITAR = 'editar';
  static const ACAO_EXCLUIR = 'excluir';

  final tarefas = <Tarefa>[
    Tarefa(
        id: 1,
        descricao: 'Fazer atividades da aula',
        prazo: DateTime.now().add(Duration(days: 5))
    )
  ];

  var _ultimoId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirForm,
        tooltip: 'Nova Tarefa',
        child: Icon(Icons.add),
      ),
    );
  }

  void _abrirForm({Tarefa? tarefaAtual, int? index}) {
    final key = GlobalKey<FormNewTaskState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tarefaAtual == null ? 'Nova Tarefa' : 'Alterar a tarefa ${tarefaAtual.id}'),
            content: FormNewTask(key: key, tarefaAtual: tarefaAtual),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')
              ),
              TextButton(
                  onPressed: () {
                    if (key.currentState != null && key.currentState!.dadosValidados()) {
                      setState(() {
                        final novaTarefa = key.currentState!.newTask;
                        if (index == null) {
                          novaTarefa.id = ++ _ultimoId;
                        } else {
                          tarefas[index] = novaTarefa;
                        }
                        tarefas.add(novaTarefa);
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Salvar')
              )
            ],
          );
        }
    );
  }


  void _excluirTarefa(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning, color: Colors.red),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                child: Text('Atenção'),
                )
              ],
            ),
            content: Text('Esse registro será deletado permanentemente'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(), child: Text('Cancelar')
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      tarefas.removeAt(index);
                    });
                  }, child: Text('Confirmar')
              ),
            ],
          );
        });
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

        return PopupMenuButton<String>(
          child: ListTile(
            title: Text('${tarefa.id} - ${tarefa.descricao}'),
            subtitle: Text(tarefa.prazo == null ? 'Tarefa sem prazo definido' : 'Prazo - ${tarefa.prazoFormatado}'),
          ),
          itemBuilder: (BuildContext context) => _criarItensMenu(),
          onSelected: (String valorSelecionado) {
            if (valorSelecionado == ACAO_EDITAR) {
              _abrirForm(tarefaAtual: tarefa, index: index);
            } else if (valorSelecionado == ACAO_EXCLUIR) {
              _excluirTarefa(index);
            }
          },
        );
      },
    );
  }

  List<PopupMenuEntry<String>> _criarItensMenu() {
    return [
      PopupMenuItem(
        value: ACAO_EDITAR,
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.black,),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                child: Text('Editar'),
              )
            ],
          )
      ),
      PopupMenuItem(
          value: ACAO_EXCLUIR,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Excluir'),
              )
            ],
          )
      )
    ];
  }
}