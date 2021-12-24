import 'package:flutter/material.dart';
import 'package:qr_turn_alert/main.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;

  void set(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    userScreenWidth = _mediaQueryData.size.width;
    userScreenHeight = _mediaQueryData.size.height;
    userScreenPadding = (userScreenWidth * 0.05);
    if (userScreenWidth < 500)
      userTextSize = 0.0;
    else
      userTextSize = 7.0;
  }
}
