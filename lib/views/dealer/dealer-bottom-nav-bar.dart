import 'package:flutter/material.dart';
import 'package:qr_turn_alert/views/dealer/dealer-homepage.dart';
import 'package:qr_turn_alert/queuepage1.dart';
import 'package:qr_turn_alert/settings.dart';

class DealerBottomNavBar extends StatefulWidget {
  @override
  _DealerBottomNavBarState createState() => _DealerBottomNavBarState();
}

class _DealerBottomNavBarState extends State<DealerBottomNavBar> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    DealerHomepage(),
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
            icon: Icon(Icons.insert_chart),
            label: 'Queue',
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
