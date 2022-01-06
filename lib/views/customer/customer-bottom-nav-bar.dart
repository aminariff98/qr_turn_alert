import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_turn_alert/scan.dart';
import 'package:qr_turn_alert/settings.dart';
import 'package:qr_turn_alert/views/customer/customer-homepage.dart';
import 'package:pandabar/pandabar.dart';

class CustomerBottomNavBar extends StatefulWidget {
  @override
  _CustomerBottomNavBar createState() => _CustomerBottomNavBar();
}

class _CustomerBottomNavBar extends State<CustomerBottomNavBar> {
  String page = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Home':
              return CustomerHomepage();
            case 'Profile':
              return SettingsPage();
            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: PandaBar(
        buttonColor: Colors.white70,
        buttonSelectedColor: Color(0xFFAD1F61),
        fabColors: [
          Color(0xFFAD1F61),
          Color(0xFFAD1F61),
        ],
        fabIcon: Icon(
          Icons.qr_code,
          color: Colors.white,
          size: 26,
        ),
        buttonData: [
          PandaBarButtonData(id: 'Home', icon: Icons.dashboard, title: 'Home'),
          PandaBarButtonData(id: 'Profile', icon: Icons.book, title: 'Profile'),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Scan()));
        },
      ),
    );
  }
}
