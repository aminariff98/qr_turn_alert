import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_turn_alert/config/config.dart';
import 'package:qr_turn_alert/controller/FirebaseUserController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_turn_alert/models/UserModel.dart';
import 'package:qr_turn_alert/views/auth/sign-up.dart';
import 'package:qr_turn_alert/views/customer/customer-bottom-nav-bar.dart';
import 'package:qr_turn_alert/views/dealer/dealer-bottom-nav-bar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool value = false;
  String email = '', password = '';
  String emailError = '', passwordError = '';
  bool _obscurePassword = true;
  late final DocumentReference<UserModel> userModel;

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');

        userModel = FirebaseUserController().getUser(user.uid);
        uid = user.uid;
        userModel.get().then((value) {
          accountType = value.get('accountType');
          fullName = value.get('fullName');

          if (accountType == 'dealer') {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DealerBottomNavBar()), (Route<dynamic> route) => false);
          } else if (accountType == 'customer') {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CustomerBottomNavBar()), (Route<dynamic> route) => false);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().set(context);

    void _togglePasswordView() {
      setState(() {
        _obscurePassword = !_obscurePassword;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: userScreenPadding),
              SvgPicture.asset(
                "assets/icons/undraw_Outdoor.svg",
                height: userScreenHeight * 0.4,
                width: userScreenWidth * 0.5,
              ),
              Container(
                padding: EdgeInsets.only(left: userScreenPadding, right: userScreenPadding),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                          border: (emailError != '') ? Border.all(width: 0.0, color: Colors.red) : Border.all(width: 0.0, color: Colors.transparent),
                          color: Color(0xFFEAF2FA),
                          borderRadius: new BorderRadius.circular(12.0)),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 1,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            email = '';
                          } else {
                            email = value;
                          }

                          emailError = '';
                        },
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
                      decoration: new BoxDecoration(
                          border: (passwordError != '') ? Border.all(width: 0.0, color: Colors.red) : Border.all(width: 0.0, color: Colors.transparent),
                          color: Color(0xFFEAF2FA),
                          borderRadius: new BorderRadius.circular(12.0)),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                        cursorColor: Color(0xFF9b9b9b),
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: _obscurePassword ? Color(0xFF9D9E9E) : Color(0xff163567),
                              size: 18,
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 1,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            password = '';
                          } else {
                            password = value;
                          }
                          passwordError = '';
                        },
                      ),
                    ),
                    (passwordError != '')
                        ? Row(children: [
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  passwordError,
                                  style: Theme.of(context).textTheme.bodyText2!.apply(color: Colors.red, fontSizeDelta: userTextSize),
                                ),
                              ),
                            )
                          ])
                        : Container(),
                    SizedBox(height: userScreenPadding),
                    Container(
                      constraints: BoxConstraints(maxWidth: userScreenWidth * 0.4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onPrimary: Colors.transparent,
                          textStyle: TextStyle(color: Colors.white),
                          padding: EdgeInsets.zero,
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color.fromRGBO(173, 31, 97, 1),
                                Color.fromRGBO(70, 0, 106, 1),
                              ],
                            ),
                          ),
                          child: Text(
                            'Sign In',
                            style: Theme.of(context).textTheme.button!.apply(
                                  color: Colors.white,
                                  fontSizeDelta: userTextSize,
                                ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: userScreenPadding / 1.5, horizontal: userScreenPadding * 2),
                        ),
                        onPressed: () {
                          if (email != '') {
                            if (password != '') {
                              EasyLoading.show();
                              _signIn();
                            } else {
                              setState(() {
                                passwordError = 'Password is empty';
                              });
                            }
                          } else {
                            setState(() {
                              emailError = 'Email is empty';
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: userScreenPadding * 2),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                        child: Text(
                          'Don\'t have an account? Sign up',
                          style: Theme.of(context).textTheme.bodyText1!.apply(
                                color: Color(0xff1877F2),
                                fontSizeDelta: userTextSize,
                              ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignUp()), (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signIn() async {
    print(email + password);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      EasyLoading.dismiss();
      uid = userCredential.user!.uid;

      userModel = FirebaseUserController().getUser(uid);
      userModel.get().then((value) {
        accountType = value.get('accountType');
        fullName = value.get('fullName');
        contactNumber = value.get('msisdn');
        if (accountType == 'dealer') {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DealerBottomNavBar()), (Route<dynamic> route) => false);
        } else if (accountType == 'customer') {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CustomerBottomNavBar()), (Route<dynamic> route) => false);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
