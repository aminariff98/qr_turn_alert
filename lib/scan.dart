// ignore: import_of_legacy_library_into_null_safe
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {

  String qrResult = "Not yet Scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Result", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
            Text(qrResult,
            textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 20.0,
            ),

        // ignore: deprecated_member_use
        FlatButton(
          padding: EdgeInsets.all(15.0),
          child: Text("Scan QR Code"),
          onPressed: () async{

            String scanning = (await BarcodeScanner.scan()) as String;
            setState(() {
              qrResult = scanning;

            });
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.blue,width: 3.0)
          )
        )
        ],
        ),
      ),
    );
  }
}
