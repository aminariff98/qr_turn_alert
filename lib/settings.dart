import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qr_turn_alert/controller/FirebaseUserController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_turn_alert/models/UserModel.dart';
import 'package:qr_turn_alert/views/auth/login.dart';
import 'package:qr_turn_alert/views/dealer/dealer-account-detail.dart';
import 'package:qr_turn_alert/views/widgets/about-app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String _name, _accountType;
  late final DocumentReference<UserModel> userModel;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    getBiometricAuth();
    userModel = FirebaseUserController().getUser(uid);
  }

  checkDeviceBiometric() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('biometricAuth', true);
      _authenticate();
      setState(() {
        biometricAuth = true;
      });
    } else {
      biometricAuth = false;
    }

    await auth.authenticate(localizedReason: 'Please authenticate to login', options: const AuthenticationOptions(biometricOnly: true));
  }

  Future<void> _authenticate() async {
    String _authorized = 'Not Authorized';
    bool _isAuthenticating = false;
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  // Future<void> _authenticateWithBiometrics() async {
  //   String _authorized = 'Not Authorized';
  //   bool _isAuthenticating = false;
  //   bool authenticated = false;
  //   try {
  //     setState(() {
  //       _isAuthenticating = true;
  //       _authorized = 'Authenticating';
  //     });
  //     authenticated = await auth.authenticate(
  //       localizedReason: 'Scan your fingerprint or face to authenticate',
  //       options: const AuthenticationOptions(
  //         useErrorDialogs: true,
  //         stickyAuth: true,
  //         biometricOnly: true,
  //       ),
  //     );
  //     setState(() {
  //       _isAuthenticating = false;
  //       _authorized = 'Authenticating';
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //     setState(() {
  //       _isAuthenticating = false;
  //       _authorized = 'Error - ${e.message}';
  //     });
  //     return;
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   final String message = authenticated ? 'Authorized' : 'Not Authorized';
  //   setState(() {
  //     _authorized = message;
  //   });
  // }

  getBiometricAuth() async {
    final prefs = await SharedPreferences.getInstance();
    biometricAuth = prefs.getBool('biometricAuth') ?? false;
  }

  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<UserModel>>(
      stream: userModel.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.requireData;
        _name = data.get('fullName');
        _accountType = data.get('accountType');

        return Scaffold(
          backgroundColor: Color.fromRGBO(173, 31, 97, 1),
          appBar: AppBar(
            title: Text('Profile'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(173, 31, 97, 1),
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: userScreenPadding, right: userScreenPadding),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/icons/profile/profile.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "$_name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        (_accountType == 'dealer') ? 'Business Account' : 'Normal Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: userScreenPadding,
                  )
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(34))),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: userScreenPadding * 2,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Settings",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Divider(
                            height: 15,
                            thickness: 2,
                          ),
                          if (_accountType == 'customer')
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: userScreenPadding),
                              title: Text('Allow Notification'),
                              trailing: CupertinoSwitch(
                                value: notification,
                                onChanged: (bool value) {
                                  setState(() {
                                    notification = value;
                                  });
                                },
                              ),
                            ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: userScreenPadding),
                            title: Text('Use Touch ID / Face ID'),
                            trailing: CupertinoSwitch(
                              value: biometricAuth,
                              onChanged: (bool value) async {
                                if (value) {
                                  checkDeviceBiometric();
                                } else {
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setBool('biometricAuth', value);
                                  setState(() {
                                    biometricAuth = value;
                                  });
                                }
                              },
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: userScreenPadding),
                            title: Text('Account'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 24,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(builder: (context) => DealerAccountDetail()),
                              );
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: userScreenPadding),
                            title: Text('Language'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 24,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Sorry, this feature will be available soon',
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: userScreenPadding),
                            title: Text('About App'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 24,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(builder: (context) => AboutApp()),
                              );
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: userScreenPadding),
                            title: Text('Logout'),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 24,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return new BackdropFilter(filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: logout(context));
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: userScreenPadding,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget logout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Color(0xffF3F6FB),
          margin: EdgeInsets.fromLTRB(userScreenPadding * 2, userScreenPadding / 2, userScreenPadding * 2, userScreenPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ListTile(
                enabled: false,
                contentPadding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 16.0),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: userScreenPadding,
                            ),
                            Text(
                              'Are you sure?',
                              style: Theme.of(context).textTheme.bodyText1!.apply(
                                    fontSizeDelta: 4,
                                  ),
                            ),
                            SizedBox(
                              height: userScreenPadding,
                            ),
                            Text(
                              'Do you want to logout from this account?',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2!.apply(fontSizeDelta: 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                onTap: () {},
              ),
              Divider(
                color: Color(0xFF9D9E9E),
                indent: 0,
                endIndent: 0,
                height: 1,
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            width: 0.5,
                            color: Color(0xFF9D9E9E),
                          ),
                        ),
                      ),
                      child: ListTile(
                        minVerticalPadding: 14,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(20.0)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Center(
                            child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: 0),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      minVerticalPadding: 14,
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('email');
                        await prefs.remove('password');
                        await prefs.setBool('biometricAuth', false);
                        EasyLoading.show();
                        MyApp().signOut(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(bottomRight: const Radius.circular(20.0)),
                      ),
                      title: Center(
                        child: Text(
                          'Logout',
                          style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: (0)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
