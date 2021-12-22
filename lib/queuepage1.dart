import 'package:flutter/material.dart';
import 'package:qr_turn_alert/analysishomepage.dart';
import 'package:qr_turn_alert/analysispage.dart';
import 'package:qr_turn_alert/analysispage1.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/queuing_detail_page.dart';

class QueuePage1 extends StatefulWidget {

  @override
  _QueuePage1State createState() => _QueuePage1State();
}

class _QueuePage1State extends State<QueuePage1> {
  @override
  Widget build(BuildContext context) {
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
