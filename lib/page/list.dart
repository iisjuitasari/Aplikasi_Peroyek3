import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Geprek Alhamdulillah'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(child: Text('Ini adalah drawer')),
            ListTile(
              title: Text('This is Tile 1'),
            ),
            ListTile(
              title: Text('This is Tile 1'),
            ),
            ListTile(
              title: Text('This is Tile 1'),
            ),
            ListTile(
              title: Text('This is Tile 1')
            ),
          ],
        ),

      ),
    );
  }
}