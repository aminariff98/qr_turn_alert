import 'package:flutter/material.dart';
import 'package:qr_turn_alert/Screens/Welcome/welcome_screen.dart';
import 'package:qr_turn_alert/config/config.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qr_turn_alert/views/auth/sign-up.dart';

late var userScreenWidth, userScreenHeight, userScreenPadding, userTextSize;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Queue',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            SizeConfig().set(context);
            if (snapshot.hasError) {
              print("You have an error! ${snapshot.error.toString()}");
              return Text('Something went  wrong!');
            } else if (snapshot.hasData) {
              return SignUp();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Container(
              child: Stack(children: <Widget>[
            Container(padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0), child: Text('Hello', style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold))),
            Container(padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0), child: Text('There', style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold))),
            Container(padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0), child: Text('.', style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.green)))
          ])),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: 'EMAIL', labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'PASSWORD', labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))),
                  obscureText: true,
                ),
                SizedBox(height: 5.0),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(child: Text('Forgot Password', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, decoration: TextDecoration.underline))),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: 40.0,
                  child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: GestureDetector(
                          onTap: () {},
                          child: Center(
                              child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          )))),
                ),
                SizedBox(height: 25.0),
                Container(
                  height: 40.0,
                  child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      elevation: 7.0,
                      child: GestureDetector(
                          onTap: () {},
                          child: Center(
                              child: Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          )))),
                )
              ]))
        ]));
  }
}
