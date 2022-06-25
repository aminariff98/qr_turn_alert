import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';
import 'package:qr_turn_alert/views/widgets/chart.dart';

class DealerBranchReport extends StatefulWidget {
  final String branchId;
  const DealerBranchReport({Key? key, required this.branchId}) : super(key: key);

  @override
  _DealerBranchReportState createState() => _DealerBranchReportState();
}

class _DealerBranchReportState extends State<DealerBranchReport> {
  var queRef = FirebaseFirestore.instance.collection('report').snapshots();
  var date, time, day, month, year, count = 0;
  var monthName;
  List checkMonthList = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];
  List monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List selectedMonth = [], selectedMonthName = [], docs = [], monthlyRecords = [0, 0, 0];
  var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    date = DateFormat('yyyy-MM-dd').format(now);
    monthName = DateFormat('MMMM').format(now);
    day = DateFormat('dd').format(now);
    month = DateFormat('MM').format(now);
    year = DateFormat('yyyy').format(now);

    for (int i = 0; i < 12; i++) {
      if (i == 0 && month == checkMonthList[i]) {
        selectedMonth.add(month);
        selectedMonth.add(checkMonthList[11]);
        selectedMonth.add(checkMonthList[10]);
        selectedMonthName.add(monthList[i]);
        selectedMonthName.add(monthList[11]);
        selectedMonthName.add(monthList[10]);
        break;
      } else if (i == 1 && month == checkMonthList[1]) {
        selectedMonth.add(month);
        selectedMonth.add(checkMonthList[0]);
        selectedMonth.add(checkMonthList[11]);
        selectedMonthName.add(monthList[i]);
        selectedMonthName.add(monthList[0]);
        selectedMonthName.add(monthList[11]);
        break;
      } else if (i >= 2) {
        for (int q = 0; q < 3; q++) {
          var index = checkMonthList.indexWhere((x) => x == month);
          selectedMonth.add(checkMonthList[index - q]);
          selectedMonthName.add(monthList[index - q]);
        }
        break;
      }
    }
    print(selectedMonthName[0]);

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F6FB),
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
                print(doc['branchId'] == widget.branchId);
                if (doc['status'] == 'completed' && doc['branchId'] == widget.branchId) {
                  count++;
                  docs.add(doc);
                  if (doc['month'] == selectedMonth[0]) {
                    monthlyRecords[0] += 1;
                  }
                  if (doc['month'] == selectedMonth[1]) {
                    monthlyRecords[1] += 1;
                  }
                  if (doc['month'] == selectedMonth[2]) {
                    monthlyRecords[2] += 1;
                  }
                }
              }).toList();
              return Column(
                children: [
                  getTotalEarningChart(),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(userScreenPadding, userScreenPadding, userScreenPadding, 0),
                    child: Text(
                      '*Records are up to only last 3 months',
                      style: Theme.of(context).textTheme.bodyText1!.apply(
                            fontSizeDelta: userTextSize,
                          ),
                    ),
                  ),
                  for (int i = 0; i < 3; i++) informationCard(i),
                  SizedBox(
                    height: userScreenPadding,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget informationCard(index) {
    print(index);
    return Card(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(userScreenPadding, userScreenPadding / 2, userScreenPadding, userScreenPadding / 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(
            height: userScreenPadding / 2,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(userScreenPadding, userScreenPadding / 2, 0.0, userScreenPadding / 2),
            alignment: Alignment.topLeft,
            child: Text(
              selectedMonthName[index],
              style: Theme.of(context).textTheme.bodyText1!.apply(
                    fontSizeDelta: userTextSize + 4,
                  ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: userScreenPadding * 2),
            child: Text(
              'Total customers : ' + monthlyRecords[index].toString(),
              style: Theme.of(context).textTheme.bodyText1!.apply(
                    fontSizeDelta: userTextSize + 4,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTotalEarningChart() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(left: userScreenPadding, right: userScreenPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Container(
        constraints: BoxConstraints(minHeight: (userScreenHeight * 0.27), maxHeight: (userScreenHeight * 0.32)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
              Color(0xFF2e1a70),
              Color(0xFFc83690),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: userScreenPadding, top: userScreenPadding, bottom: userScreenPadding * 2),
              alignment: Alignment.topLeft,
              child: Text(
                'No. of customers last 7 days',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB((userScreenWidth * 0.07), 0.0, (userScreenWidth * 0.07), 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: userScreenHeight * 0.18,
                      child: Chart(
                        data: docs,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
