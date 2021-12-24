import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/covid19screens.dart';
import 'package:qr_turn_alert/views/dealer/dealer-bottom-nav-bar.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

int QueueCurrentFinance = 28;
int QueueCurrentInvestment = 16;
int QueueCurrentLoan = 6;
int QueueCurrentDeposit = 18;
int QueueCurrentSelected = 0;

int QueueNextFinance = QueueCurrentFinance + 1;
int QueueNextInvestment = QueueCurrentInvestment + 1;
int QueueNextLoan = QueueCurrentLoan + 1;
int QueueNextDeposit = QueueCurrentDeposit + 1;
int QueueNextSelected = QueueCurrentFinance + 1;

int QueueAvailableFinance = QueueCurrentFinance + QueueWaitingFinance;
int QueueAvailableInvestment = QueueCurrentInvestment + QueueWaitingInvestment;
int QueueAvailableLoan = QueueCurrentLoan + QueueWaitingLoan;
int QueueAvailableDeposit = QueueCurrentDeposit + QueueWaitingDeposit;
int QueueAvailableSelected = QueueCurrentSelected;

int QueuePositionFinance = 19;
int QueuePositionInvestment = 19;
int QueuePositionLoan = 19;
int QueuePositionDeposit = 19;
int QueuePositionSelected = 0;

int QueueWaitingFinance = 7;
int QueueWaitingInvestment = 1;
int QueueWaitingLoan = 0;
int QueueWaitingDeposit = 3;
int QueueWaitingSelected = 0;

String QueueActive = "Inactive";
int test = 0;

const maxSeconds = 60;
int seconds = maxSeconds;
Timer? timer;

Duration _duration = Duration(seconds: QueueWaitingFinance * 180);
String QueueLocation = "Maybank Suria KLCC";

String SelectedCounter = '';
String timeleft = '';

class QueueDetails extends StatefulWidget {
  @override
  _QueueDetailsState createState() => _QueueDetailsState();
}

class _QueueDetailsState extends State<QueueDetails> {
  FlutterLocalNotificationsPlugin localNotification = new FlutterLocalNotificationsPlugin();

  static const maxSeconds = 20;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void startTimer() {
    test = 0;
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }

      if (seconds == 0) {
        test = test + 1;
        if (test == 1) {
          CreateAlertDialog1(context);
          QueueWaitingSelected = QueueWaitingSelected - 1;
          displayNotification('Queue');
        }
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    test = 0;
    startTimer();
    /*var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var initializationSettings = new InitializationSettings(android: androidInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);*/
    initializeSetting();
    tz.initializeTimeZones();
    displayNotification('Queue');
  }

  /*Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails("channelID", "local Notification", "This is the description of the notification, you can write anything", importance: Importance.high);
    var generalNotificationDetails = new NotificationDetails(android: androidDetails);
    await localNotification.show(0, "Title", "Body", generalNotificationDetails);
  }*/

  CreateAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to leave the queue?'),
            actions: <Widget>[
              FlatButton(
                  child: Text('Leave'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DealerBottomNavBar()),
                    );
                  }),
              FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
            ],
          );
        });
  }

  CreateAlertDialog1(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reminder'),
            content: Text('It is currently your turn. Please proceed at counter $SelectedCounter'),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DealerBottomNavBar()),
                    );
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = seconds == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Queueing Details"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Text(
            QueueLocation,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            SelectedCounter,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Your Ticket Number",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 100,
              ),
              padding: const EdgeInsets.all(10),
              height: 200,
              width: 10,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Row(
                  children: <Widget>[Text(QueuePositionSelected.toString(), style: const TextStyle(color: Colors.white, fontSize: 100, fontWeight: FontWeight.bold), textAlign: TextAlign.center)],
                ),
              ])),
          SizedBox(
            height: 30,
          ),
          Text(
            "Number of People ahead in line: $QueueWaitingSelected",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Estimated Waiting Time",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text("$seconds", textAlign: TextAlign.center),
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
                    child: Text("Leave Queue",
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () {
                      //_showNotification();
                      CreateAlertDialog(context);
                      //displayNotification('Queue');
                      //startTimer();
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Nav()),

                      );*/
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
          ),
        ],
      ),
    );
  }

  Future<void> displayNotification(String match) async {
    notificationsPlugin.zonedSchedule(0, match, 'This is a notification to indicate that it is currrently your turn for the queue', tz.TZDateTime.now(tz.local).add(Duration(seconds: 20)),
        NotificationDetails(android: AndroidNotificationDetails('channel id', 'channel name', 'channel description')),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidAllowWhileIdle: true);
  }
}

void initializeSetting() async {
  var initializeAndroid = AndroidInitializationSettings('vqueue');
  var initializeSetting = InitializationSettings(android: initializeAndroid);
  await notificationsPlugin.initialize(initializeSetting);
}
