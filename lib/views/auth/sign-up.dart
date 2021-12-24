import 'package:flutter/material.dart';
import 'package:qr_turn_alert/controller/FirebaseUserController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_turn_alert/views/auth/login.dart';
import 'package:qr_turn_alert/views/customer/customer-bottom-nav-bar.dart';
import 'package:qr_turn_alert/views/dealer/dealer-bottom-nav-bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool dealerAccount = false;
  String email = '', password = '', confirmPassword = '', fullName = '';
  String emailError = '', passwordError = '', confirmPasswordError = '', fullNameError = '';
  bool _obscurePassword = true, _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    void _togglePasswordView() {
      setState(() {
        _obscurePassword = !_obscurePassword;
      });
    }

    void _toggleConfirmPasswordView() {
      setState(() {
        _obscureConfirmPassword = !_obscureConfirmPassword;
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
                          confirmPasswordError = '';
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
                    SizedBox(height: userScreenPadding / 2),
                    Container(
                      decoration: new BoxDecoration(
                          border: (confirmPasswordError != '') ? Border.all(width: 0.0, color: Colors.red) : Border.all(width: 0.0, color: Colors.transparent),
                          color: Color(0xFFEAF2FA),
                          borderRadius: new BorderRadius.circular(12.0)),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                        cursorColor: Color(0xFF9b9b9b),
                        decoration: InputDecoration(
                          suffix: InkWell(
                            onTap: _toggleConfirmPasswordView,
                            child: Icon(
                              _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                              color: _obscureConfirmPassword ? Color(0xFF9D9E9E) : Color(0xff163567),
                              size: 18,
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Confirm Password',
                          hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                        ),
                        obscureText: _obscureConfirmPassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 1,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            confirmPassword = '';
                          } else {
                            confirmPassword = value;
                          }
                          passwordError = '';
                          confirmPasswordError = '';
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              (confirmPasswordError != '')
                  ? Row(children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: userScreenPadding + 10),
                          child: Text(
                            passwordError,
                            style: Theme.of(context).textTheme.bodyText2!.apply(color: Colors.red, fontSizeDelta: userTextSize),
                          ),
                        ),
                      )
                    ])
                  : Container(),
              SizedBox(height: userScreenPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: dealerAccount,
                    onChanged: (value) {
                      setState(() {
                        this.dealerAccount = value!;
                      });
                    },
                  ),
                  Text(
                    'Sign up as a business account',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
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
                      'Sign Up',
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
                        if (password == confirmPassword) {
                          EasyLoading.show();
                          _register();
                        } else {
                          setState(() {
                            passwordError = 'Password did not match';
                            confirmPasswordError = 'Password did not match';
                          });
                        }
                      } else {
                        setState(() {
                          passwordError = 'Password is empty';
                        });
                      }
                    } else {
                      if (password == '') {
                        passwordError = 'Password is empty';
                        confirmPasswordError = 'Password is empty';
                      }
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
                    'Already have an account? Sign in',
                    style: Theme.of(context).textTheme.bodyText1!.apply(
                          color: Color(0xff1877F2),
                          fontSizeDelta: userTextSize,
                        ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      late String accountType;
      if (dealerAccount) {
        accountType = 'dealer';
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DealerBottomNavBar()), (Route<dynamic> route) => false);
      } else {
        accountType = 'customer';
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CustomerBottomNavBar()), (Route<dynamic> route) => false);
      }
      FirebaseUserController().addUser(userCredential.user!.uid, fullName, accountType);
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        passwordError = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        emailError = 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

  setButtonEnabled() {}
}
