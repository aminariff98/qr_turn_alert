import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:math';

import 'package:qr_turn_alert/main.dart';

class AppNavBarCurve extends StatelessWidget {
  final String title;
  final bool backButton;

  AppNavBarCurve({required this.title, required this.backButton});

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    double userBackground, userImageBackground;
    if (userScreenWidth < 500) {
      userBackground = 0.3 + roundDouble((kToolbarHeight / 1000), 2);
      userImageBackground = userScreenWidth * 1.4;
    } else {
      userBackground = 0.25 + roundDouble((kToolbarHeight / 1000), 2);
      userImageBackground = userScreenWidth * 1.4;

      if (MediaQuery.of(context).size.height < MediaQuery.of(context).size.width) {
        userBackground = 0.25 + roundDouble((kToolbarHeight / 1000), 2);
        userImageBackground = userScreenHeight * 1.2;
      }
    }
    return Scaffold(
      body: Container(
        color: Color(0xffF3F6FB),
        child: Stack(
          children: <Widget>[
            ClipRect(
              child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor: userBackground,
                widthFactor: 1,
                child: Container(
                  width: userImageBackground,
                  height: userImageBackground,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/gradient-bg2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                icon: new Icon(
                                  Icons.arrow_back_ios,
                                  color: backButton ? Colors.white : Colors.transparent,
                                  size: 18.0 + userTextSize,
                                ),
                                onPressed: () {
                                  if (backButton) {
                                    EasyLoading.dismiss();
                                    Navigator.pop(context);
                                  }
                                }),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              child: Text(
                                title,
                                style: Theme.of(context).textTheme.headline1!.apply(
                                      fontSizeDelta: userTextSize,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
