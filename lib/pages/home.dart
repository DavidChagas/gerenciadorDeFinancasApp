import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Placeholder(),
        floatingActionButton: FabCircularMenu(children: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                print('Home');
              }),
          IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                print('Favorite');
              })
        ]),
      ),
    );
  }
}
