import 'package:flutter/material.dart';
import 'package:qr_turn_alert/analysispage.dart';
import 'package:qr_turn_alert/covid19homescreen.dart';
import 'package:qr_turn_alert/home_screen.dart';
import 'package:qr_turn_alert/homepage.dart';
import 'package:qr_turn_alert/homepage1.dart';
import 'package:qr_turn_alert/queuepage.dart';
import 'package:qr_turn_alert/queuepage1.dart';
import 'package:qr_turn_alert/settings.dart';

class Nav extends StatefulWidget {

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    //HomePage1(),
    HomeScreen1(),
    QueuePage1(),
    SettingsPage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Bottom Nav Bar'),
      //),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text('Queue'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
