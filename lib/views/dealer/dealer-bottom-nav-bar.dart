import 'package:flutter/material.dart';
import 'package:qr_turn_alert/scan.dart';
import 'package:qr_turn_alert/views/dealer/dealer-create-branch.dart';
import 'package:qr_turn_alert/views/dealer/dealer-homepage.dart';
import 'package:qr_turn_alert/settings.dart';
import 'package:pandabar/pandabar.dart';

class DealerBottomNavBar extends StatefulWidget {
  @override
  _DealerBottomNavBarState createState() => _DealerBottomNavBarState();
}

class _DealerBottomNavBarState extends State<DealerBottomNavBar> {
  String page = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Home':
              return DealerHomepage();
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
          Icons.add,
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterBranch(
                  additionalUid: branchCount.toString(),
                ),
              ));
        },
      ),
    );
  }
}
