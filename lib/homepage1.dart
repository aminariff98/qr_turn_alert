import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:qr_turn_alert/scan.dart';

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {

  String qrResult = "Not yet Scanned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: myDetailsContainer1(),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
                            ),
                          ),),
                      ],)
                ),
              ),
            ),
          ),



          new GestureDetector(
              onTap: (){
                print("Container clicked");
              },
            child: Container(
              padding: EdgeInsets.all(16),
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 106.0),
                            child: myDetailsContainer1(),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),

                          ),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ),

          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Material(
                color: Colors.white,
                elevation: 14,
                borderRadius: BorderRadius.circular(24),
                shadowColor: Color(0x802196F3),
                child: FlatButton(
                  height: 150,
                  padding: EdgeInsets.all(15.0),
                  child: Text("Click here to queue"),
                  onPressed: () async{

                    String scanning = (await BarcodeScanner.scan()) as String;
                    setState(() {
                    qrResult = scanning;

                    });
                  },
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),

                    )
                  )
              ),
          ),
        ],
      ),
    );
  }

  Widget myDetailsContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("Click here to begin scannning",
            style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),

      ],
    );
  }

  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      height: 150,
      child: Text(text),
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => widget));
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.blue,width: 3.0),

      ),
    );
  }
}