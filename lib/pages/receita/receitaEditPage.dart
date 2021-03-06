import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gerenciadorDeFinancasApp/dominio/receita.dart';
import 'package:gerenciadorDeFinancasApp/pages/menu.dart';
import 'package:gerenciadorDeFinancasApp/util/receitaHelper.dart';

class ReceitaEditPage extends StatefulWidget {
  ReceitaEditPage({Key key, this.objeto}) : super(key: key);

  final Receita objeto;

  @override
  _ReceitaEditPageState createState() => _ReceitaEditPageState();
}

class _ReceitaEditPageState extends State<ReceitaEditPage> {
  final _formKey = GlobalKey<FormState>();

  Receita obj;
  List<String> opcoes = ["Pendente", "Recebido"];

  @override
  void initState() {
    super.initState();
    obj = widget.objeto;
  }

  void _salvar() {
    if (obj.id == null) {
      ReceitaHelper()
          .inserir(obj)
          .then((value) => {Navigator.pop(context, 'salvou')})
          .catchError((e) => {print(e)});
    } else {
      ReceitaHelper()
          .alterar(obj)
          .then((value) => {Navigator.pop(context, 'editou')})
          .catchError((e) => {print(e)});
    }
  }

  void _excluir() {
    ReceitaHelper()
        .excluir(obj.id)
        .then((value) => {Navigator.pop(context, 'excluído')})
        .catchError((e) => {print(e)});
  }

  void _cancelar() {
    Navigator.pop(context, 'cancelou');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(obj.id != null ? 'Editar Receita' : 'Cadastrar Receita'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DateTimePicker(
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                      labelText: 'Data'),
                  initialValue: obj.data,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  onChanged: (val) {
                    obj.data = val;
                  },
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.money),
                        border: OutlineInputBorder(),
                        labelText: 'Valor'),
                    inputFormatters: [
                      CurrencyTextInputFormatter(symbol: 'R\$')
                    ],
                    keyboardType: TextInputType.number,
                    initialValue: obj.valor,
                    onChanged: (text) {
                      obj.valor = text;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.text_fields),
                        border: OutlineInputBorder(),
                        labelText: 'Descrição'),
                    keyboardType: TextInputType.text,
                    initialValue: obj.descricao,
                    onChanged: (text) {
                      obj.descricao = text;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Recebido'),
                        leading: Radio(
                          value: 'Recebido',
                          groupValue: obj.recebido,
                          onChanged: (value) {
                            setState(() {
                              obj.recebido = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Pendente'),
                        leading: Radio(
                          value: 'Pendente',
                          groupValue: obj.recebido,
                          onChanged: (value) {
                            setState(() {
                              obj.recebido = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _salvar();
                            } else {
                              print('sss');
                            }
                          },
                          child: Text('Salvar'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _cancelar();
                          },
                          child: Text('Cancelar'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _excluir();
                          },
                          child: Text('Excluir'),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }
}
