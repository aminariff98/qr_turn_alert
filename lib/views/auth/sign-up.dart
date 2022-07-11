import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:qr_turn_alert/controller/FirebaseUserController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_turn_alert/views/auth/login.dart';
import 'package:qr_turn_alert/views/customer/customer-bottom-nav-bar.dart';
import 'package:qr_turn_alert/views/dealer/dealer-bottom-nav-bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool dealerAccount = false;
  String email = '', password = '', confirmPassword = '', _fullName = '', msisdn = '', mykad = '';
  String emailError = '', passwordError = '', confirmPasswordError = '', fullNameError = '', msisdnError = '', mykadError = '';
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            ClipPath(
              clipper: WaveClipperTwo(flip: false, reverse: false),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color.fromRGBO(173, 31, 97, 1),
                      Color.fromRGBO(70, 0, 106, 1),
                    ],
                  ),
                ),
                height: userScreenHeight * 0.6,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: userScreenHeight * 0.12),
                  Center(
                    child: Container(
                      width: userScreenWidth * 0.65,
                      height: userScreenHeight * 0.16,
                      child: Image(
                        image: AssetImage('assets/icons/app/queue.png'),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: EdgeInsets.only(left: userScreenPadding, right: userScreenPadding, top: 30.0, bottom: 15.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
                      child: Container(
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
                            (confirmPasswordError != '')
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
                              decoration: new BoxDecoration(border: Border.all(width: 0.0, color: Colors.transparent), color: Color(0xFFEAF2FA), borderRadius: new BorderRadius.circular(12.0)),
                              child: TextFormField(
                                style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                                cursorColor: Color(0xFF9b9b9b),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: 'Full Name',
                                  hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                maxLines: 1,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    _fullName = '';
                                  } else {
                                    _fullName = value;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: userScreenPadding / 2),
                            TextFormField(
                              style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(12),
                              ],
                              cursorColor: Color(0xFF9b9b9b),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFEAF2FA),
                                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: (mykadError == '') ? BorderSide(color: Colors.transparent, width: 0.0) : BorderSide(color: Colors.red, width: 1.0),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: (mykadError == '') ? BorderSide(color: Colors.transparent, width: 0.0) : BorderSide(color: Colors.red, width: 1.0),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Identity Number',
                                hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                              ),
                              maxLines: 1,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  mykad = '';
                                } else {
                                  mykad = value;
                                }

                                setState(() {});
                                mykadError = '';
                              },
                            ),
                            (mykadError != '')
                                ? Row(children: [
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          mykadError,
                                          style: Theme.of(context).textTheme.bodyText2!.apply(color: Colors.red, fontSizeDelta: userTextSize),
                                        ),
                                      ),
                                    )
                                  ])
                                : SizedBox(),
                            SizedBox(height: userScreenPadding / 2),
                            Container(
                              decoration: new BoxDecoration(border: Border.all(width: 0.0, color: Colors.transparent), color: Color(0xFFEAF2FA), borderRadius: new BorderRadius.circular(12.0)),
                              child: TextField(
                                style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: InputDecoration(
                                  fillColor: Color(0xFFEAF2FA),
                                  filled: true,
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                                    child: Text(
                                      '+60 ',
                                      style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 15.0),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: (msisdnError == '') ? BorderSide(color: Colors.transparent, width: 0.0) : BorderSide(color: Colors.red, width: 1.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: (msisdnError == '') ? BorderSide(color: Colors.transparent, width: 0.0) : BorderSide(color: Colors.red, width: 1.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                                ),
                                maxLines: 1,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    msisdn = '';
                                  } else {
                                    msisdn = value;
                                  }

                                  setState(() {});
                                  msisdnError = '';
                                },
                              ),
                            ),
                            (msisdnError != '')
                                ? Row(children: [
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          msisdnError,
                                          style: Theme.of(context).textTheme.bodyText2!.apply(color: Colors.red, fontSizeDelta: userTextSize),
                                        ),
                                      ),
                                    )
                                  ])
                                : SizedBox(),
                            SizedBox(height: userScreenPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Theme(
                                  data: ThemeData(unselectedWidgetColor: Color(0xFF9D9E9E)),
                                  child: Checkbox(
                                    focusColor: Color(0xFF9D9E9E),
                                    checkColor: Colors.white,
                                    activeColor: Color(0xFFAD1F61),
                                    value: dealerAccount,
                                    onChanged: (value) {
                                      setState(() {
                                        this.dealerAccount = value!;
                                      });
                                    },
                                  ),
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
                                    if (mykad == '') {
                                      mykadError = 'The Identity Number field is empty';
                                      setState(() {});
                                    }
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
                                  }),
                            ),
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
                            SizedBox(height: userScreenPadding * 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: userScreenHeight * 0.03),
                ],
              ),
            ),
          ],
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
      uid = userCredential.user!.uid;
      fullName = _fullName;
      late String accountType;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      biometricAuth = false;
      await prefs.setBool('biometricAuth', false);
      if (dealerAccount) {
        accountType = 'dealer';
        FirebaseUserController().addUser(userCredential.user!.uid, _fullName, accountType, '0' + msisdn, email, mykad, password);
        Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DealerBottomNavBar()), (Route<dynamic> route) => false);
      } else {
        accountType = 'customer';
        FirebaseUserController().addUser(userCredential.user!.uid, fullName, accountType, '0' + msisdn, email, mykad, password);
        Future.delayed(Duration(seconds: 1));
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CustomerBottomNavBar()), (Route<dynamic> route) => false);
      }
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
}
