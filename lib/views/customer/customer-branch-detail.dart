import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qr_turn_alert/controller/FirebaseBranchController.dart';
import 'package:qr_turn_alert/controller/FirebaseQueController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/models/BranchModel.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();

String? selectedNotificationPayload;
FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

class CustomerBranchDetail extends StatefulWidget {
  final dynamic id;
  const CustomerBranchDetail({Key? key, this.id}) : super(key: key);

  @override
  _CustomerBranchDetailState createState() => _CustomerBranchDetailState();
}

class _CustomerBranchDetailState extends State<CustomerBranchDetail> {
  late final DocumentReference<BranchModel> branchModel;
  late String id, name, long, lat, state, category, contactNumber, image;
  var queRef = FirebaseFirestore.instance.collection('que').snapshots();
  var count = 0, date, time;
  var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    date = DateFormat('yyyy-MM-dd').format(now);
    branchModel = FirebaseBranchController().getBranch(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<BranchModel>>(
      stream: branchModel.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;
        id = data.get('branchUid');
        name = data.get('branchName');
        image = data.get('branchImageUrl');
        lat = data.get('branchLat');
        long = data.get('branchLong');
        state = data.get('branchState');
        category = data.get('branchCategory');
        contactNumber = data.get('branchMsisdn');
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: AppNavBarFlat(
              title: name,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(userScreenPadding, userScreenPadding, userScreenPadding, userScreenPadding),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    padding: EdgeInsets.all(userScreenPadding),
                    color: Colors.transparent,
                    width: userScreenWidth,
                    child: Row(
                      children: [
                        Flexible(flex: 1, child: Image.network(image)),
                        SizedBox(
                          width: userScreenPadding,
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                              ),
                              SizedBox(
                                height: userScreenPadding / 2,
                              ),
                              StreamBuilder(
                                  stream: queRef,
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    count = 0;
                                    snapshot.data!.docs.map((DocumentSnapshot doc) {
                                      if (doc['status'] == 'active' && doc['branchId'] == id) count++;
                                    }).toList();

                                    return Row(
                                      children: [
                                        Icon(Icons.timer),
                                        Text(
                                          ' Waiting : ',
                                          style: Theme.of(context).textTheme.subtitle2!.apply(fontSizeDelta: userTextSize),
                                        ),
                                        SizedBox(
                                          width: userScreenPadding,
                                        ),
                                        Text(
                                          count.toString(),
                                          style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: queRef,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Column(
                      children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                        return (doc['uid'] == uid && doc['branchId'] == id && doc['date'] == date.toString() && doc['status'] == 'active')
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(userScreenPadding, userScreenPadding / 2, userScreenPadding, userScreenPadding),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: userScreenPadding * 2,
                                    ),
                                    Text(
                                      (count < 5) ? 'Your turn is near, you should be at the location' : 'You are currently in line, we\'ll notify you once the number is near',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.subtitle2!.apply(fontSizeDelta: userTextSize),
                                    ),
                                    Image(
                                      image: AssetImage('assets/icons/customer/waiting.gif'),
                                    ),
                                    Text(
                                      'Que started at :',
                                      style: Theme.of(context).textTheme.subtitle2!.apply(fontSizeDelta: userTextSize),
                                    ),
                                    Text(
                                      doc["date"] + '\n' + doc["time"],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.subtitle2!.apply(fontSizeDelta: userTextSize),
                                    ),
                                    SizedBox(
                                      height: userScreenPadding,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: userScreenWidth / 5,
                                        right: userScreenWidth / 5,
                                        bottom: 10,
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          onPrimary: Colors.transparent,
                                          textStyle: TextStyle(color: Colors.white),
                                          padding: EdgeInsets.zero,
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50.0),
                                            gradient: LinearGradient(
                                              colors: <Color>[
                                                Color.fromRGBO(173, 31, 97, 1),
                                                Color.fromRGBO(70, 0, 106, 1),
                                              ],
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 30,
                                              ),
                                              Text(
                                                'Go to Location',
                                                style: Theme.of(context).textTheme.button!.apply(
                                                      fontSizeDelta: userTextSize,
                                                      color: Colors.white,
                                                    ),
                                              )
                                            ],
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                        ),
                                        onPressed: _launchURL,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        FirebaseQueController().updateQue('$uid-' + id + '-$date');
                                        _cancelAllNotifications();
                                      },
                                      child: Text(
                                        'Cancel Que',
                                        style: Theme.of(context).textTheme.subtitle2!.apply(
                                              color: Color(0xFF9D9E9E),
                                              fontSizeDelta: userTextSize,
                                            ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: userScreenPadding * 2,
                                    ),
                                  ],
                                ),
                              )
                            : Container();
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: getSubmitButton(),
          ),
        );
      },
    );
  }

  Widget queBody(que) {
    return Text(count.toString());
  }

  Widget getSubmitButton() {
    return Container(
      padding: EdgeInsets.only(
        left: userScreenWidth / 5,
        right: userScreenWidth / 5,
        bottom: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          textStyle: TextStyle(color: Colors.white),
          padding: EdgeInsets.zero,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(173, 31, 97, 1),
                Color.fromRGBO(70, 0, 106, 1),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30,
              ),
              Text(
                'Que',
                style: Theme.of(context).textTheme.button!.apply(
                      fontSizeDelta: userTextSize,
                      color: Colors.white,
                    ),
              )
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        onPressed: () {
          time = DateFormat('HH:mm:ss').format(now);
          if (notification) setNotification();
          FirebaseQueController().addQue(uid, id, fullName, date, time);
        },
      ),
    );
  }

  _launchURL() async {
    var url = 'https://www.google.com/maps/search/' + lat + ',' + long;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> setNotification() async {
    var androidSpecifics = AndroidNotificationDetails(
      'test id',
      'test notification',
      priority: Priority.max,
      importance: Importance.high,
      when: tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)).millisecondsSinceEpoch,
    );
    var iOSSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidSpecifics, iOS: iOSSpecifics);

    await FlutterLocalNotificationsPlugin().zonedSchedule(1000, 'VQueue', 'Check number in line', tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)), platformChannelSpecifics,
        androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
