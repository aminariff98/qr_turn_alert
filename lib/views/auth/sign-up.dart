import 'package:flutter/material.dart';
import 'package:qr_turn_alert/Screens/Welcome/components/rounded_button.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confimrPasswordController = TextEditingController();
    late String email, password, confirmPassword;
    String emailError = '', passwordError = '', confirmPasswordError = '';

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.headline3!.apply(
                    fontSizeDelta: userTextSize,
                  ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: userScreenPadding / 2),
            child: Text(
              'Get started by keying in your ID Number',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText2!.apply(
                    color: Color(0xFF9D9E9E),
                    fontSizeDelta: userTextSize,
                  ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              //padding: EdgeInsets.only(left: 10.0),
              //alignment: Alignment.center,
              decoration: new BoxDecoration(
                  border: (emailError != '') ? Border.all(width: 0.0, color: Colors.red) : Border.all(width: 0.0, color: Colors.transparent),
                  color: Color(0xFFEAF2FA),
                  borderRadius: new BorderRadius.circular(12.0)),
              child: TextFormField(
                style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                cursorColor: Color(0xFF9b9b9b),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'ID Number',
                  hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 1,
                onChanged: (identityNumberValue) {
                  if (identityNumberValue.isEmpty) {
                    email = '';
                  } else {
                    email = identityNumberValue;
                  }

                  emailError = '';
                  setButtonEnabled();
                },
              ),
            ),
          ),
          (emailError != '')
              ? Row(children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        emailError,
                        style: Theme.of(context).textTheme.bodyText2!.apply(color: Colors.red, fontSizeDelta: userTextSize),
                      ),
                    ),
                  )
                ])
              : Container(),
          SizedBox(height: userScreenPadding / 2),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Choose your type of registration tool',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText2!.apply(
                    color: Color(0xFF9D9E9E),
                    fontSizeDelta: userTextSize,
                  ),
            ),
          ),
          Text(
            "VQUEUE",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SvgPicture.asset(
            "assets/icons/undraw_Outdoor.svg",
            height: userScreenHeight * 0.4,
            width: userScreenWidth * 0.5,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Container(
                  width: (userScreenWidth * 0.8),
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
                  width: (userScreenWidth) * 0.8,
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
                  width: (userScreenWidth * 0.8),
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
    );
  }

  setButtonEnabled() {}
}
