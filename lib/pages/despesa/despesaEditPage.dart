import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gerenciadorDeFinancasApp/dominio/despesa.dart';
import 'package:gerenciadorDeFinancasApp/pages/menu.dart';
import 'package:gerenciadorDeFinancasApp/util/despesaHelper.dart';

class DespesaEditPage extends StatefulWidget {
  DespesaEditPage({Key key, this.objeto}) : super(key: key);

  final Despesa objeto;

  @override
  _DespesaEditPageState createState() => _DespesaEditPageState();
}

class _DespesaEditPageState extends State<DespesaEditPage> {
  final _formKey = GlobalKey<FormState>();

  Despesa obj;
  List<String> opcoes = ["Pendente", "Pago"];

  @override
  void initState() {
    super.initState();
    obj = widget.objeto;
  }

  void _salvar() {
    if (obj.id == null) {
      DespesaHelper()
          .inserir(obj)
          .then((value) => {Navigator.pop(context, 'salvou')})
          .catchError((e) => {print(e)});
    } else {
      DespesaHelper()
          .alterar(obj)
          .then((value) => {Navigator.pop(context, 'editou')})
          .catchError((e) => {print(e)});
    }
  }

  void _excluir() {
    DespesaHelper()
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
        title: Text(obj.id != null ? 'Editar Despesa' : 'Cadastrar Despesa'),
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
                        title: const Text('Pago'),
                        leading: Radio(
                          value: 'Pago',
                          groupValue: obj.pago,
                          onChanged: (value) {
                            setState(() {
                              obj.pago = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Pendente'),
                        leading: Radio(
                          value: 'Pendente',
                          groupValue: obj.pago,
                          onChanged: (value) {
                            setState(() {
                              obj.pago = value;
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
