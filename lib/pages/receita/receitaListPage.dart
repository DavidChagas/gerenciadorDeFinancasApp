import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gerenciadorDeFinancasApp/dominio/receita.dart';
import 'package:gerenciadorDeFinancasApp/pages/menu.dart';
import 'package:gerenciadorDeFinancasApp/pages/receita/receitaEditPage.dart';
import 'package:gerenciadorDeFinancasApp/util/Dialogos.dart';

class ReceitaListPage extends StatefulWidget {
  ReceitaListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReceitaListPageState createState() => _ReceitaListPageState();
}

class _ReceitaListPageState extends State<ReceitaListPage> {
  List<Receita> lista = new List();

  @override
  void initState() {
    super.initState();
    obterTodos();
  }

  void obterTodos() {}

  void _addReceita() async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReceitaEditPage(
              objeto: new Receita(),
            )));
    //print(res);
    obterTodos();
    Dialogos.showToastSuccess(res);
  }

  void selecionarReceita(Receita p) async {}

  void _excluir(Receita obj) {}

  @override
  Widget build(BuildContext context) {
    if (lista.length > 0) {
      return Scaffold(
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            children: lista
                .map((data) => ListTile(
                      leading: Icon(Icons.person),
                      title: Text(data.descricao),
                      onTap: () => selecionarReceita(data),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'editar') {
                            selecionarReceita(data);
                          } else {
                            _excluir(data);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(child: Text('Editar'), value: 'editar'),
                          PopupMenuItem(
                              child: Text('Excluir'), value: 'excluir'),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addReceita,
          tooltip: 'Increment',
          child: Icon(
            Icons.person_add,
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      );
    } else {
      return Scaffold(
        body: Center(
            child: Text('Você não possui nenhuma receita cadastrada ainda :(')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addReceita,
          label: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBar: Menu(),
      );
    }
  }
}
