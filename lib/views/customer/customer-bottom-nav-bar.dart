import 'package:flutter/material.dart';
import 'package:qr_turn_alert/covid19homescreen1.dart';

class CustomerBottomNavBar extends StatefulWidget {
  @override
  _CustomerBottomNavBar createState() => _CustomerBottomNavBar();
}

class _CustomerBottomNavBar extends State<CustomerBottomNavBar> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen2(),
    HomeScreen2(),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
