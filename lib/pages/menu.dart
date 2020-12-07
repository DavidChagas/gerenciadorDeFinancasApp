import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int indexselecionado = 1;

  @override
  void initState() {
    super.initState();

    Navigator.popUntil(context, (route) {
      switch (route.settings.name) {
        case '/receita':
          indexselecionado = 2;
          break;
        case '/home':
          indexselecionado = 1;
          break;
        case '/despesa':
          indexselecionado = 0;
          break;
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    void alteraIndex(index) {
      if (index == 2) {
        Navigator.of(context).pushNamed('/receita');
      }
      if (index == 1) {
        Navigator.of(context).pushNamed('/home');
      }
      if (index == 0) {
        Navigator.of(context).pushNamed('/despesa');
      }

      indexselecionado = index;
      print(indexselecionado);
    }

    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: Colors.white,
        selectedItemBackgroundColor: Colors.green,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: Colors.black,
      ),
      selectedIndex: indexselecionado,
      onSelectTab: (index) => alteraIndex(index),
      items: [
        FFNavigationBarItem(
          iconData: Icons.trending_down,
          label: 'Despesas',
        ),
        FFNavigationBarItem(
          iconData: Icons.donut_small,
          label: 'Home',
        ),
        FFNavigationBarItem(
          iconData: Icons.trending_up,
          label: 'Receitas',
        ),
      ],
    );
  }
}
