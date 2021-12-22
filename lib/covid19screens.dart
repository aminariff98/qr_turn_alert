import 'package:flutter/material.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/homepage1.dart';
import 'package:qr_turn_alert/nav.dart';
import 'package:qr_turn_alert/queuing_detail_page.dart';

class Button1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RaisedButton(
        onPressed: () {Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => QueueDetails()),

    );
    },

        child: const Text('Join Queue', style: TextStyle(fontSize: 20)),
        color: kPrimaryColor,
        textColor: Colors.white,
        elevation: 5,
      ),
    );
  }
}

class Button2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RaisedButton(
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Nav()),

        );
        },

        child: const Text('Leave Queue', style: TextStyle(fontSize: 20)),
        color: kPrimaryColor,
        textColor: Colors.white,
        elevation: 5,
      ),
    );
  }
}
