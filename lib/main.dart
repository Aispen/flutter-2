import 'package:flutter/material.dart';
import 'package:flutter_02/Drink.dart';
import 'package:flutter_02/Hotmeal.dart';
import 'package:flutter_02/Soup.dart';
import 'package:flutter_02/Homepage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "2 Praktinis",
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPage createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
////////Methods-Navigator///////

  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Homepage(),
    Soup(),
    Hotmeal(),
    Drink(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

////////Methods-END///////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Receptu app')),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Soups'),
            icon: Icon(Icons.fastfood),
          ),
          BottomNavigationBarItem(
            title: Text('Hot Meals'),
            icon: Icon(Icons.local_dining),
          ),
          BottomNavigationBarItem(
            title: Text('Drinks'),
            icon: Icon(Icons.local_drink),
          ),
        ],
      ),
    );
  }
}
