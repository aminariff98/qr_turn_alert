import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_turn_alert/Screens/Welcome/components/background.dart';
import 'package:qr_turn_alert/Screens/Welcome/components/rounded_button1.dart';
import 'package:qr_turn_alert/Screens/Welcome/components/rounded_button2.dart';
import 'package:qr_turn_alert/Screens/Welcome/welcome_screen.dart';
import 'package:qr_turn_alert/Screens/Welcome/welcome_screen2.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/Screens/Welcome/components/rounded_button.dart';
import 'package:qr_turn_alert/nav.dart';
import 'package:qr_turn_alert/navGuest.dart';
import 'package:qr_turn_alert/signup.dart';

/*class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "WELCOME TO VQUEUE",
              style: TextStyle(fontWeight: FontWeight.bold),
        ),
          SvgPicture.asset(
          "assets/icons/undraw_Signin.svg",
          height: size.height * 0.4,
            width: size.width * 0.5,
        ),
          Container(
            width: size.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: kPrimaryColor,
                  onPressed: () {},
                  child: Text(
                      "LOGIN",
                  style: TextStyle(color: Colors.white),
                  ),
              ),
            )
          )

        ]
      )
    );
  }
}*/

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "VQUEUE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SvgPicture.asset(
              "assets/icons/undraw_Park.svg",
              height: size.height * 0.4,
              width: size.width * 0.5,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    width: (size.width * 0.8),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: (size.width * 0.8),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(child: Text('Forgot Password?', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, decoration: TextDecoration.underline))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton1(
              text: "Proceed As Guest",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavGuest()),
                );
              },
            ),
            RoundedButton(
              text: "Login",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Nav()),
                );
              },
            ),
            RoundedButton2(
              text: "Sign Up",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
