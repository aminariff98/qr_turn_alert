import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_turn_alert/config/config.dart';
import 'package:qr_turn_alert/config/theme.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_turn_alert/views/auth/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

late var userScreenWidth, userScreenHeight, userScreenPadding, userTextSize;
late var fullName, accountType, uid, contactNumber;
bool notification = true;
FirebaseFirestore firestore = FirebaseFirestore.instance;
firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  MyApp().configLoading();
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Queue',
      builder: EasyLoading.init(),
      theme: theme(),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          SizeConfig().set(context);
          if (snapshot.hasError) {
            print("You have an error! ${snapshot.error.toString()}");
            return Text('Something went  wrong!');
          } else if (snapshot.hasData) {
            return Login();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void signOut(context) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false);
  }

  void configLoading() {
    EasyLoading.instance
      ..indicatorWidget = SpinKitRing(
        color: Color.fromRGBO(173, 31, 97, 1),
        size: 50.0,
      )
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[];
  }
}
