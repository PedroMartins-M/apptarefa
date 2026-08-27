import 'package:flutter/material.dart';

class ListaTarefasPage extends StatefulWidget {
  const ListaTarefasPage({super.key});

  @override
  State<ListaTarefasPage> createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefasPage> {
  final List<Map<String, dynamic>> tarefas = [];

  // Marcar tarefa como Concluida/Pendente
  void marcarSituacao(int index) {
    setState(() {
      tarefas[index]['situacao'] = !tarefas[index]['situacao'];
    });
  }

  // Remover Tarefa
  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  // Adcionar Tarefa
  void adicionarTarefa() {

    final adcionarController = TextEditingController();

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Nova Tarefa'),
        content: TextField(
          controller: adcionarController,
          decoration: InputDecoration(hintText: "Digite sua tarefa.."),
        ),
        actions: [
            TextButton(onPressed: () => Navigator.pop(context),
            child: Text('Cancelar')
          ),
           TextButton(onPressed: () {
            if(adcionarController.text.isNotEmpty){
              setState(() {
                tarefas.add({'titulo': adcionarController.text,
                'situacao': false});
              });
              Navigator.pop(context);
            }
           },
            child: Text('Adcionar')
            ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

  final List<Map<String, dynamic>> tarefas = [

    {'titulo' : 'Configuração do Ambiente', 'situacao' : true},
    {'titulo' : 'Fazer compras', 'situacao' : false},
    {'titulo' : 'Estudar inglês', 'situacao' : false},
    {'titulo' : 'Fazer compras', 'situacao' : true},
    {'titulo' : 'Pagar a fatura', 'situacao' : true},
    {'titulo' : 'Sair as 22h10', 'situacao' : false},
  ];


    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        centerTitle: true,
      ),

<<<<<<< HEAD
      body: tarefas.isEmpty
          ? Center(
              child: Text(
                'Nenhuma Tarefa Encontrada',
                style: TextStyle(
                  fontSize: 20,
                  color: (Colors.grey),
=======
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: tarefas.length,
        itemBuilder: (context, index) {

          final tarefa = tarefas[index];
          final bool situacao = tarefa['situacao'];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(
                situacao ? Icons.check_circle : Icons.circle_outlined,
                color: situacao ? Colors.green : Colors.grey,
              ),
              title: Text(
                tarefa['titulo'],
                style: TextStyle(
                  decoration: situacao ? TextDecoration.lineThrough : TextDecoration.none,
>>>>>>> e119d157c09eec9b1343eb6711d71eb45df56ad8
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];
                final bool situacao = tarefa['situacao'];

<<<<<<< HEAD
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () => marcarSituacao(index),
                      child: Icon(
                        situacao ? Icons.check_circle : Icons.circle_outlined,
                        color: situacao ? Colors.green : Colors.grey,
                      ),
                    ),
                    title: Text(
                      tarefa['titulo'],
                      style: TextStyle(
                        decoration: situacao
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(situacao ? 'Concluida' : 'Pendente'),
                    trailing: GestureDetector(
                      onTap: () => removerTarefa(index),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarTarefa,
        child: Icon(Icons.add),
=======
              subtitle:  Text(situacao ?'Concluida' : 'Pendente'),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          );
        }
>>>>>>> e119d157c09eec9b1343eb6711d71eb45df56ad8
      ),
    );
  }
}
