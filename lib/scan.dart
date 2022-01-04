import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:qr_turn_alert/controller/FirebaseQueController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/views/customer/customer-bottom-nav-bar.dart';
import 'package:qr_turn_alert/views/customer/customer-branch-detail.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String qrResult = "Nothing Scanned";
  var date, time;
  var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    date = DateFormat('yyyy-MM-dd').format(now);
    scanQr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppNavBarFlat(
          title: 'Scan',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(userScreenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Text(
            //   "Result",
            //   style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.center,
            // ),
            Text(
              '$qrResult',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            // SizedBox(
            //   height: userScreenPadding,
            // ),
            // FlatButton(
            //     padding: EdgeInsets.all(15.0),
            //     child: Text("Scan QR Code"),
            //     onPressed: () async {
            //       String scanning = (await BarcodeScanner.scan()) as String;
            //       setState(() {
            //         qrResult = scanning;
            //       });
            //     },
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.blue, width: 3.0)))
          ],
        ),
      ),
    );
  }

  Future<void> scanQr() async {
    dynamic scanned = (await BarcodeScanner.scan()).rawContent;
    qrResult = scanned.toString();

    date = DateFormat('yyyy-MM-dd').format(now);
    time = DateFormat('HH:mm:ss').format(now);

    FirebaseQueController().addQue(uid, qrResult, fullName, date, time);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CustomerBottomNavBar()), (Route<dynamic> route) => false);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CustomerBranchDetail(
                  id: qrResult,
                )));
  }
}
