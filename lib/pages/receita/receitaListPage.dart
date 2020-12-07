import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gerenciadorDeFinancasApp/dominio/receita.dart';
import 'package:gerenciadorDeFinancasApp/pages/menu.dart';
import 'package:gerenciadorDeFinancasApp/pages/receita/receitaEditPage.dart';
import 'package:gerenciadorDeFinancasApp/util/Dialogos.dart';
import 'package:gerenciadorDeFinancasApp/util/receitaHelper.dart';

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

  void obterTodos() {
    ReceitaHelper().obterTodos().then((value) => {
          setState(() {
            print(value);
            lista = value;
          })
        });
  }

  void _addReceita() async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReceitaEditPage(
              objeto: new Receita(),
            )));
    //print(res);
    obterTodos();
    Dialogos.showToastSuccess(res);
  }

  void selecionarReceita(Receita p) async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReceitaEditPage(
              objeto: p,
            )));
    obterTodos();
    Dialogos.showToastSuccess(res);
  }

  void _excluir(Receita obj) {
    Dialogos.showConfirmDialog(
        context,
        'Confirma exclusão?',
        () => {
              ReceitaHelper()
                  .excluir(obj.id)
                  .then((value) =>
                      {Dialogos.showToastSuccess('Excluído'), obterTodos()})
                  .catchError((e) => {
                        print(e),
                        Dialogos.showToastError(e.toString()),
                      })
            });
  }

  @override
  Widget build(BuildContext context) {
    if (lista.length > 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Receitas'),
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            children: lista
                .map((data) => ListTile(
                    leading: Icon(Icons.money),
                    title: Text(data.valor),
                    subtitle: Text(DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(
                            data.data.replaceAll('-', '').toString()))),
                    onTap: () => selecionarReceita(data),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () => selecionarReceita(data),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => _excluir(data),
                          )
                        ],
                      ),
                    )))
                .toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addReceita,
          label: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBar: Menu(),
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
