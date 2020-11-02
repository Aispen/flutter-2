import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
      child: new Text(
        "Homepage",
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
