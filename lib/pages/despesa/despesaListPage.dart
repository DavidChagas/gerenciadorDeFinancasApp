import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gerenciadorDeFinancasApp/dominio/despesa.dart';
import 'package:gerenciadorDeFinancasApp/pages/despesa/despesaEditPage.dart';
import 'package:gerenciadorDeFinancasApp/pages/menu.dart';
import 'package:gerenciadorDeFinancasApp/util/Dialogos.dart';
import 'package:gerenciadorDeFinancasApp/util/DespesaHelper.dart';

class DespesaListPage extends StatefulWidget {
  DespesaListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DespesaListPageState createState() => _DespesaListPageState();
}

class _DespesaListPageState extends State<DespesaListPage> {
  List<Despesa> lista = new List();
  String total;

  @override
  void initState() {
    super.initState();
    getTotalDespesas();
    obterTodos();
  }

  getTotalDespesas() {
    DespesaHelper()
        .totalDespesas()
        .then((res) => {total = res[0]['total'].toStringAsFixed(2)})
        .catchError((e) => {print(e)});
  }

  void obterTodos() {
    DespesaHelper().obterTodos().then((value) => {
          setState(() {
            lista = value;
            montaFiltro();
          })
        });
  }

  void montaFiltro() {
    lista.forEach((despesa) => {print(despesa.data)});
  }

  void _addDespesa() async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DespesaEditPage(
              objeto: new Despesa(),
            )));
    //print(res);
    obterTodos();
    Dialogos.showToastSuccess(res);
  }

  void selecionarDespesa(Despesa p) async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DespesaEditPage(
              objeto: p,
            )));
    obterTodos();
    Dialogos.showToastSuccess(res);
  }

  void _excluir(Despesa obj) {
    Dialogos.showConfirmDialog(
        context,
        'Confirma exclusão?',
        () => {
              DespesaHelper()
                  .excluir(obj.id)
                  .then((value) => {
                        Dialogos.showToastSuccess('Excluído'),
                        obterTodos(),
                        getTotalDespesas()
                      })
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
          title: Text('Despesas'),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Despesa total R\$ $total',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: lista
                  .map((data) => ListTile(
                      leading: Icon(Icons.money),
                      title: Text(data.valor),
                      subtitle: Text(DateFormat('dd/MM/yyyy').format(
                          DateTime.parse(
                              data.data.replaceAll('-', '').toString()))),
                      onTap: () => selecionarDespesa(data),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                              onPressed: () => selecionarDespesa(data),
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
          )
        ]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addDespesa,
          label: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBar: Menu(),
      );
    } else {
      return Scaffold(
        body: Center(
            child: Text('Você não possui nenhuma despesa cadastrada ainda :)')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addDespesa,
          label: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        bottomNavigationBar: Menu(),
      );
    }
  }
}
