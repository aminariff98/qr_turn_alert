import 'package:flutter/material.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/nav.dart';
import 'package:qr_turn_alert/navGuest.dart';

class RoundedButton1 extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton1({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          color: color,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NavGuest()));
          },
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}