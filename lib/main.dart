import 'package:flutter/material.dart';
import 'package:gerenciadorDeFinancasApp/pages/despesa/despesaListPage.dart';
import 'package:gerenciadorDeFinancasApp/pages/home.dart';
import 'package:gerenciadorDeFinancasApp/pages/receita/receitaEditPage.dart';
import 'package:gerenciadorDeFinancasApp/pages/receita/receitaListPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Finanças',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Bem Vindo!'),
      routes: {
        '/home': (context) => HomePage(),
        '/receita': (context) => ReceitaListPage(),
        '/despesa': (context) => DespesaListPage(),
      },
    );
  }
}
