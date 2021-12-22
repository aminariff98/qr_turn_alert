import 'package:flutter/material.dart';
import 'package:qr_turn_alert/analysishomepage.dart';
import 'package:qr_turn_alert/analysispage.dart';
import 'package:qr_turn_alert/analysispage1.dart';
import 'package:qr_turn_alert/constants.dart';

class QueuePage extends StatefulWidget {

  @override
  _QueuePageState createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Queue'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 294,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(
                  'assets/images/maybank-klcc.jpg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Maybank Suria KLCC',
              style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),textAlign: TextAlign.center,),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.greenAccent,
                  height: 200,
                  width: 160,
                  child: Column(
                    children: <Widget>[
                      Text('Financing Counter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ), textAlign: TextAlign.center,),
                      SizedBox(height: 15,),
                      Text('Current',
                        style: TextStyle(
                          color: Colors.white,
                        ), textAlign: TextAlign.center,),
                      Text('28',
                        style: TextStyle(
                          fontSize: 80,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15,),
                      Text('Next: 29',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,),
                      Text('Queuing: 7',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.greenAccent,
                  height: 200,
                  width: 160,
                  child: Column(
                    children: <Widget>[
                      Text('Investment Counter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ), textAlign: TextAlign.center,),
                      SizedBox(height: 15,),
                      Text('Current',
                        style: TextStyle(
                          color: Colors.white,
                        ), textAlign: TextAlign.center,),
                      Text('16',
                        style: TextStyle(
                          fontSize: 80,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15,),
                      Text('Next: 17',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,),
                      Text('Queuing: 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.greenAccent,
                  height: 200,
                  width: 160,
                  child: Column(
                    children: <Widget>[
                      Text('Loan Counter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ), textAlign: TextAlign.center,),
                      SizedBox(height: 15,),
                      Text('Current',
                        style: TextStyle(
                          color: Colors.white,
                        ), textAlign: TextAlign.center,),
                      Text('6',
                        style: TextStyle(
                          fontSize: 80,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15,),
                      Text('Next: None',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,),
                      Text('Queuing: 0',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.greenAccent,
                  height: 200,
                  width: 160,
                  child: Column(
                    children: <Widget>[
                      Text('Deposit Counter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ), textAlign: TextAlign.center,),
                      SizedBox(height: 15,),
                      Text('Current',
                        style: TextStyle(
                          color: Colors.white,
                        ), textAlign: TextAlign.center,),
                      Text('18',
                        style: TextStyle(
                          fontSize: 80,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15,),
                      Text('Next: 19',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,),
                      Text('Queuing: 3',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 0,),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                    color: kPrimaryColor,
                    elevation: 14,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: Color(0x802196F3),
                    child: FlatButton(
                        height: 50,
                        padding: EdgeInsets.all(15.0),
                        child: Text("                               View Analytics                            ", style: const TextStyle(
                          color: Colors.white,)),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => AnalysisHomepage()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),

                        )
                    )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
