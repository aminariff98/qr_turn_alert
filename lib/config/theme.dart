import 'package:flutter/material.dart';

// import 'constants.dart';
ThemeData theme() {
  return ThemeData(
    brightness: Brightness.dark,
    canvasColor: Color(0xffF3F6FB),
    primaryColor: Color(0xFFAD1F61),
    accentColor: Color(0xFF46006A),
    // fontFamily: 'Calibri',

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        onPrimary: Colors.transparent,
        textStyle: TextStyle(color: Colors.white),
        padding: EdgeInsets.zero,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
    ),
    textTheme: TextTheme(
      //app-bar
      headline1: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      //body header
      headline2: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
      //body header normal fontWeight
      headline3: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..shader = LinearGradient(
            colors: <Color>[
              Color(0XFFAD1F61),
              Color(0XFF46006A),
            ],
          ).createShader(Rect.fromLTWH(0.0, 0.0, 500.0, 70.0)),
      ),
      //Coin balance
      headline4: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xFF9D9E9E)),
      headline5: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
      headline6: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Color(0xff163567)),
      //body
      bodyText1: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
      bodyText2: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Color(0xff163567)),
      subtitle1: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal, color: Color(0xff163567)),
      subtitle2: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xff163567)),
      //button
      button: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
      //foot note
      caption: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Color(0xFF9D9E9E)),
    ),
  );
}
