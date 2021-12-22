import 'package:flutter/material.dart';
import 'package:qr_turn_alert/Screens/Welcome/welcome_screen2.dart';
import 'package:qr_turn_alert/analysispage.dart';
import 'package:qr_turn_alert/covid19homescreen.dart';
import 'package:qr_turn_alert/covid19homescreen1.dart';
import 'package:qr_turn_alert/home_screen.dart';
import 'package:qr_turn_alert/homepage.dart';
import 'package:qr_turn_alert/homepage1.dart';
import 'package:qr_turn_alert/queuepage.dart';
import 'package:qr_turn_alert/settings.dart';

class NavGuest extends StatefulWidget {

  @override
  _NavGuest createState() => _NavGuest();
}

class _NavGuest extends State<NavGuest> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    //HomePage1(),
    HomeScreen2(),
    WelcomeScreen2(),
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
