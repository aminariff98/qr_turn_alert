import 'package:flutter/material.dart';
import 'package:qr_turn_alert/main.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  void set(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    userScreenWidth = _mediaQueryData.size.width;
    userScreenPadding = _mediaQueryData.size.width * 0.05;
    userScreenHeight = _mediaQueryData.size.height;

    if (userScreenWidth < 500) {
      userTextSize = 0.0;
    } else {
      userTextSize = 7.0;
      if (userScreenHeight < userScreenWidth) {
        userScreenHeight = MediaQuery.of(context).size.width;
        userScreenWidth = MediaQuery.of(context).size.height;
      }
    }
    userScreenPadding = (userScreenWidth * 0.05);
  }
}
