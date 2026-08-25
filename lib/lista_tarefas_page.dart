import 'package:flutter/material.dart';

class ListaTarefasPage extends StatelessWidget {
  const ListaTarefasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        centerTitle: true,
      ),

      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              title: Text(
                'Configurar o Ambiente de Desenvolvimento',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),

              subtitle: Text('Concluida'),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),

          Card(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(
                Icons.circle_outlined,
                color: Colors.grey,
              ),
              title: Text(
                'Criar Projeto em Flutter',
              ),

              subtitle: Text('Pendente'),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),

          Card(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
              title: Text(
                ' Iniciar Desenvolvimento do App de Compras',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),

              subtitle: Text('Concluida com sucesso'),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),

          Card(
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Icon(
                Icons.circle_outlined,
                color: const Color.fromARGB(255, 206, 15, 63),
              ),
              title: Text(
                'FInalizar App de Compras',
              ),

              subtitle: Text('Tarefa Futura'),
              trailing: Icon(
                Icons.delete_outline,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {},
      child: Icon(Icons.add),
       ),
    );
  }
}
