import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreen();
  }
}

class HomeScreen extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: new Container(
          child: new Text('HOME SCREEN'),
        )
      ),
    );
  }
}