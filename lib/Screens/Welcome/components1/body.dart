import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_turn_alert/Screens/Welcome/components/background.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/Screens/Welcome/components/rounded_button.dart';
import 'package:qr_turn_alert/views/sign-up.dart';

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

class Body2 extends StatelessWidget {
  bool value = false;

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
              "assets/icons/undraw_Outdoor.svg",
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
                  SizedBox(height: 20.0),
                  Container(
                    width: (size.width * 0.8),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(value: value, onChanged: (value) => this.value = value!),
                Text(
                  'Sign up as a business account',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RoundedButton(
              text: "Sign Up",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
