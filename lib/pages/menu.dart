import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int indexselecionado = 0;

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
          iconData: Icons.calendar_today,
          label: 'Despesas',
        ),
        FFNavigationBarItem(
          iconData: Icons.people,
          label: 'Home',
        ),
        FFNavigationBarItem(
          iconData: Icons.attach_money,
          label: 'Receitas',
        ),
      ],
    );
  }
}
