import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppNavBarFlat extends StatelessWidget {
  final String title;

  AppNavBarFlat({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F6FB),
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 5.0),
          icon: new Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          color: Colors.white,
          onPressed: () {
            EasyLoading.dismiss();
            Navigator.of(context).pop();
          },
        ),
        centerTitle: false,
        title: Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[
            Color.fromRGBO(173, 31, 97, 1),
            Color.fromRGBO(70, 0, 106, 1),
          ])),
        ),
      ),
    );
  }
}
