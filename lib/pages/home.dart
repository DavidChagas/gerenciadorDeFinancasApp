import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gerenciadorDeFinancasApp/dominio/despesa.dart';
import 'package:gerenciadorDeFinancasApp/pages/menu.dart';
import 'package:gerenciadorDeFinancasApp/util/despesaHelper.dart';
import 'package:gerenciadorDeFinancasApp/util/receitaHelper.dart';
import 'package:graphic/graphic.dart' as graphic;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Despesa objDespesa;
  double totalDespesas = 100.00;
  num totalReceitas = 200;

  @override
  void initState() {
    super.initState();
    getTotalDespesas();
  }

  getTotalDespesas() {
    DespesaHelper()
        .totalDespesas()
        .then((res) => {totalDespesas = res[0]['total']})
        .catchError((e) => {print(e)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciado de Finanças'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: Text('Resumo Mensal', style: TextStyle(fontSize: 20)),
                padding: EdgeInsets.fromLTRB(0, 100, 0, 10),
              ),
              Container(
                width: 350,
                height: 300,
                child: graphic.Chart(
                  data: [
                    {'genre': 'Receita', 'sold': totalReceitas},
                    {'genre': 'Despesa', 'sold': totalDespesas},
                  ],
                  scales: {
                    'genre': graphic.CatScale(
                      accessor: (map) => map['genre'] as String,
                    ),
                    'sold': graphic.LinearScale(
                      accessor: (map) => map['sold'] as num,
                      nice: true,
                    )
                  },
                  geoms: [
                    graphic.IntervalGeom(
                      position: graphic.PositionAttr(field: 'genre*sold'),
                    )
                  ],
                  axes: {
                    'genre': graphic.Defaults.horizontalAxis,
                    'sold': graphic.Defaults.verticalAxis,
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }
}
