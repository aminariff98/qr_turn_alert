import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:qr_turn_alert/controller/FirebaseQueController.dart';
import 'package:qr_turn_alert/controller/FirebaseReportController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';

class DealerManageBranch extends StatefulWidget {
  final String branchId;
  const DealerManageBranch({Key? key, required this.branchId}) : super(key: key);

  @override
  _DealerManageBranchState createState() => _DealerManageBranchState();
}

class _DealerManageBranchState extends State<DealerManageBranch> {
  var queRef = FirebaseFirestore.instance.collection('que').snapshots();
  var date, time, day, month, year, count = 0;
  var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    date = DateFormat('yyyy-MM-dd').format(now);
    day = DateFormat('dd').format(now);
    month = DateFormat('MM').format(now);
    year = DateFormat('yyyy').format(now);
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppNavBarFlat(
          title: 'Manage Que',
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: userScreenPadding,
          ),
          StreamBuilder(
              stream: queRef,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                snapshot.data!.docs.map((DocumentSnapshot doc) {
                  if (doc['status'] == 'active' && doc['branchId'] == widget.branchId) count++;
                }).toList();

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timer),
                        SizedBox(
                          width: userScreenPadding,
                        ),
                        Text(
                          'In Que : ',
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
                    ),
                    Column(
                      children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                        return branchCard(doc);
                      }).toList(),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget branchCard(que) {
    return (que['branchId'] == widget.branchId && que['status'] == 'active')
        ? GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 4.0,
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(userScreenPadding, 0, userScreenPadding, userScreenPadding),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: EdgeInsets.all(userScreenPadding),
                color: Colors.transparent,
                width: userScreenWidth,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            que['name'],
                            style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                          ),
                          SizedBox(
                            height: userScreenPadding / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Color(0xFF9D9E9E),
                              ),
                              SizedBox(
                                width: userScreenPadding / 2,
                              ),
                              Text(
                                que['time'],
                                style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          time = DateFormat('HH:mm:ss').format(now);
                          FirebaseReportController().addQue(uid, que['branchId'], que['name'], date, time, day, month, year);
                          FirebaseQueController().updateQue(que['queId']);
                        },
                        child: Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
