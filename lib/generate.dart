import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';

class BranchQrCode extends StatefulWidget {
  final String id;

  const BranchQrCode({Key? key, required this.id}) : super(key: key);

  @override
  _BranchQrCodeState createState() => _BranchQrCodeState();
}

class _BranchQrCodeState extends State<BranchQrCode> {
  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    String qrData = widget.id;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppNavBarFlat(
            title: 'Qr Code',
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
              QrImage(
                data: qrData,
                version: QrVersions.auto,
                gapless: false,
              ),
            ])));
  }
}
