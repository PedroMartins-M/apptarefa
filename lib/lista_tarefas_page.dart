import 'package:apptarefa/database_helper.dart';
import 'package:apptarefa/sobre_page.dart';
import 'package:flutter/material.dart';

class ListaTarefasPage extends StatefulWidget {
  const ListaTarefasPage({super.key});

  @override
  State<ListaTarefasPage> createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefasPage> {
  List<Map<String, dynamic>> tarefas = [];

  String? filtroAtual;

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  void carregarTarefas() async {
    //Carregar as tarefas do banco de dados
    final dados = await DatabaseHelper.buscarTarefas(filtro: filtroAtual);
    setState(() {
      tarefas = dados;
    });
  }

  // Marcar tarefa como Concluida/Pendente
  void marcarSituacao(int index) async {
    final tarefa = tarefas[index];

    // Descomente a linha e use o operador ternário para alternar o valor
    final novaSituacao = tarefa['situacao'] == 1 ? 0 : 1;

    await DatabaseHelper.atualizarSituacao(
      tarefa['id'],
      novaSituacao, // Passa a nova situação invertida
    );

    carregarTarefas(); // Atualiza a lista de tarefas
  }

  void aplicarFiltro(String? novoFiltro){
    filtroAtual = novoFiltro;
    Navigator.pop(context);
    carregarTarefas();
  }
 

  //Remover Tarefa
  void removerTarefa(int index) async {
    final tarefa = tarefas[index];

    await DatabaseHelper.removerTarefa(tarefa['id']);

    carregarTarefas(); // Atualiza a lista de tarefas
  }

  //Adicionar Tarefa
  void adicionarTarefa() {
    final adicionarControle = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nova Tarefa'),
          content: TextField(
            controller: adicionarControle,
            decoration: InputDecoration(hintText: 'Digite sua Tarefa...'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (adicionarControle.text.isNotEmpty) {
                  await DatabaseHelper.inserirTarefa(adicionarControle.text);

                  carregarTarefas(); // Atualiza a lista de tarefas

                  // Fecha o diálogo apenas se o contexto continuar ativo após o await
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas tarefas"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text(
                "Minhas Tarefas",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Todas as Tarefas'),
              selected: filtroAtual == null,
              selectedColor: Colors.blue[700],
              onTap: () => aplicarFiltro(null),
            ),
            ListTile(
              leading: Icon(Icons.pending_actions),
              title: Text('Pendentes'),
              selected: filtroAtual == 'pendentes',
              selectedColor: Colors.blue[700],
              onTap: () => aplicarFiltro('pendentes'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: Text('Concluidas'),
              selected: filtroAtual == 'concluidos',
              selectedColor: Colors.blue[700],
              onTap: () => aplicarFiltro('concluidas'),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Sobre o Aplicativo'),
              onTap: () {
 
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SobrePage()
                  ),
                );
 
              },
            ),
          ],
        ),
      ),
      body: tarefas.isEmpty
          ? Center(
              child: Text(
                'Nenhuma Tarefa ainda. Toque em + para adicionar.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];
                final bool situacao = tarefa['situacao'] == 1;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    //Modificar tarefa onTap
                    leading: GestureDetector(
                      onTap: () => marcarSituacao(index),
                      child: Icon(
                        situacao ? Icons.check_circle : Icons.circle_outlined,
                        color: situacao ? Colors.green : Colors.redAccent,
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
                    subtitle: situacao ? Text('Concluida') : Text('Pendente'),
                    //Remover Tarefa onTap
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
        //onPressed: () => adicionarTarefa(),
        onPressed: adicionarTarefa,
        //deixa o botão redondo
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
