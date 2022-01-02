import 'package:flutter/material.dart';
import 'package:qr_turn_alert/constants.dart';

class Homepage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 17.0, right: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Material(
                  color: kPrimaryColor,
                  elevation: 14,
                  borderRadius: BorderRadius.circular(10),
                  shadowColor: Color(0x802196F3),
                  child: FlatButton(
                      height: 50,
                      padding: EdgeInsets.all(15.0),
                      child: Text("Setup QR Code",
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => BranchQrCode(id: ,)));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
            ),
            Image(
                image: NetworkImage(
                    "https://thumbs.dreamstime.com/b/qr-code-scan-icon-comic-style-scanner-id-vector-cartoon-illustration-white-isolated-background-barcode-business-concept-154939907.jpg")),
            /*flatButton("Scan QR Code", Scan()),
            SizedBox(
              height: 10.0,
            ),
            flatButton("Generate QR Code", Generate()),*/
          ],
        ),
      ),
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      child: Text(text),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Colors.blue, width: 3.0)),
    );
  }
}
