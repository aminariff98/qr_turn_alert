import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_turn_alert/analysishomepage.dart';
import 'package:qr_turn_alert/analysispage.dart';
import 'package:qr_turn_alert/analysispage1.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/queuepage.dart';
import 'package:qr_turn_alert/queuing_detail_page.dart';


class PreQueuePage extends StatefulWidget {

  @override
  _PreQueuePageState createState() => _PreQueuePageState();
}

class _PreQueuePageState extends State<PreQueuePage> {
  final database = FirebaseDatabase.instance.reference();

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => seconds--);

    });

  }

  int selectedRadio = 0;
  int selectedRadioTile = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    final dailySpecialRef = database.child('dailySpecial/');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Maybank Suria KLCC'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: <Widget>[
          Material(
            elevation: 14,
            child: Container(

              height: 222,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(
                    'assets/images/maybank-klcc.jpg'),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),

          Material(
            elevation: 7,
            child: Column(
              children: [
                SizedBox(height: 10),
                Text('Queue Information', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),textAlign: TextAlign.center,),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: kPrimaryColor,
                        height: 160,
                        width: 160,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 3,),
                            Text('Finance Counter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ), textAlign: TextAlign.center,),
                            SizedBox(height: 15,),
                            Text('Current',
                              style: TextStyle(
                                color: Colors.white,
                              ), textAlign: TextAlign.center,),
                            Text('$QueueCurrentFinance',
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ), textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text('Next: $QueueNextFinance',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ), textAlign: TextAlign.center,),
                            Text('Queuing: $QueueWaitingFinance',
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
                        color: kPrimaryColor,
                        height: 160,
                        width: 160,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 3,),
                            Text('Investment Counter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ), textAlign: TextAlign.center,),
                            SizedBox(height: 15,),
                            Text('Current',
                              style: TextStyle(
                                color: Colors.white,
                              ), textAlign: TextAlign.center,),
                            Text('$QueueCurrentInvestment',
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ), textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text('Next: $QueueNextInvestment',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ), textAlign: TextAlign.center,),
                            Text('Queuing: $QueueWaitingInvestment',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: kPrimaryColor,
                        height: 160,
                        width: 160,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 3,),
                            Text('Loan Counter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ), textAlign: TextAlign.center,),
                            SizedBox(height: 15,),
                            Text('Current',
                              style: TextStyle(
                                color: Colors.white,
                              ), textAlign: TextAlign.center,),
                            Text('$QueueCurrentLoan',
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ), textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text('Next: $QueueNextLoan',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ), textAlign: TextAlign.center,),
                            Text('Queuing: $QueueWaitingLoan',
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
                        color: kPrimaryColor,
                        height: 160,
                        width: 160,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 3,),
                            Text('Deposit Counter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ), textAlign: TextAlign.center,),
                            SizedBox(height: 15,),
                            Text('Current',
                              style: TextStyle(
                                color: Colors.white,
                              ), textAlign: TextAlign.center,),
                            Text('$QueueCurrentDeposit',
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ), textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text('Next: $QueueNextDeposit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ), textAlign: TextAlign.center,),
                            Text('Queuing: $QueueWaitingDeposit',
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
              ],
            ),
          ),
          SizedBox(height: 10,),
          Material(
            elevation: 7,
            child: Container(
              color: Colors.white,
              width: 200,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text('Please select your counter', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),textAlign: TextAlign.center,),
                  SizedBox(height: 5,),
                  RadioListTile(value: 1, groupValue: selectedRadio,
                    title: Text("Finance"),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");
                      setSelectedRadio(1);
                      SelectedCounter = 'Finance';
                      QueuePositionFinance += 1;
                      QueueAvailableFinance += 1;
                      QueuePositionSelected = QueueAvailableFinance;
                      QueueWaitingSelected = QueueWaitingFinance;


                    },
                    activeColor: Colors.lightBlue,
                  ),
                  RadioListTile(value: 2, groupValue: selectedRadio,
                    title: Text("Investment"),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");
                      setSelectedRadio(2);
                      SelectedCounter = 'Investment';
                      QueueAvailableInvestment += 1;
                      QueuePositionSelected = QueueAvailableInvestment;
                      QueueWaitingSelected = QueueWaitingInvestment;


                    },
                    activeColor: Colors.lightBlue,
                  ),
                  RadioListTile(value: 3, groupValue: selectedRadio,
                    title: Text("Loan"),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");
                      setSelectedRadio(3);
                      SelectedCounter = 'Loan';
                      QueueAvailableLoan += 1;
                      QueuePositionSelected = QueueAvailableLoan;
                      QueueWaitingSelected = QueueWaitingLoan;


                    },
                    activeColor: Colors.lightBlue,
                  ),
                  RadioListTile(value: 4, groupValue: selectedRadio,
                    title: Text("Deposit"),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");
                      setSelectedRadio(4);
                      SelectedCounter = 'Deposit';
                      QueueAvailableDeposit += 1;
                      QueuePositionSelected = QueueAvailableDeposit;
                      QueueWaitingSelected = QueueWaitingDeposit;


                    },
                    activeColor: Colors.lightBlue,
                  ),
              ]
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                    color: kPrimaryColor,
                    elevation: 7,
                    borderRadius: BorderRadius.circular(10),
                    shadowColor: Color(0x802196F3),
                    child: FlatButton(
                        height: 50,
                        padding: EdgeInsets.all(15.0),
                        child: Text("                                   Join Queue                              ", style: const TextStyle(
                          color: Colors.white,)),
                        onPressed: () {
                          startTimer();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => QueueDetails()));
                          dailySpecialRef.set({'description': 'Test', 'price': 'Test'})
                          .then((_) => print("Records has been successfully written"))
                          .catchError((error) => print("You got an error! $error"));

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
