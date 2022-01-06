import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/views/customer/customer-branch-detail.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';
import 'package:qr_turn_alert/views/widgets/drop-down-list.dart';

class BranchCategory extends StatefulWidget {
  final String category;
  BranchCategory({Key? key, required this.category}) : super(key: key);
  @override
  _BranchCategoryState createState() => _BranchCategoryState();
}

class _BranchCategoryState extends State<BranchCategory> {
  var branchRef = FirebaseFirestore.instance.collection('branch').snapshots();
  var selectedState = 'All';
  List _states = [
    'All',
    'Johor',
    'Kedah',
    'Kelantan',
    'Melaka',
    'Negeri Sembilan',
    'Pahang',
    'Perak',
    'Perlis',
    'Pulau Pinang',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu',
    'W.P. Kuala Lumpur',
    'W.P. Labuan',
    'W.P. Putrajaya'
  ];

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppNavBarFlat(
          title: widget.category,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: userScreenPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  // border: Border.all(width: 3.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    getStateDropDownValue(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        '$selectedState',
                        style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xff163567),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: userScreenPadding,
          ),
          StreamBuilder(
              stream: branchRef,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var branchList = [];
                snapshot.data!.docs.map((DocumentSnapshot doc) {
                  if (selectedState == 'All') {
                    branchList.add(doc);
                  } else if (doc['branchState'] == selectedState) {
                    branchList.add(doc);
                  }
                }).toList();

                return Column(
                  children: [for (var i = 0; i < branchList.length; i++) branchCard(branchList[i])],
                );
              }),
        ],
      ),
    );
  }

  Widget branchCard(branch) {
    return (branch['branchCategory'] == widget.category)
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerBranchDetail(
                            id: branch['branchUid'],
                          )));
            },
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
                    Flexible(flex: 1, child: Image.network(branch['branchImageUrl'])),
                    SizedBox(
                      width: userScreenPadding,
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            branch['branchName'],
                            style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                          ),
                          SizedBox(
                            height: userScreenPadding / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color(0xFF9D9E9E),
                              ),
                              Text(
                                branch['branchCity'],
                                style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  getStateDropDownValue(BuildContext context) async {
    var index = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: DropDownList(
            title: 'State',
            items: _states,
            selectedValue: selectedState,
          ),
        );
      },
    );

    if (index != null) {
      setState(() {
        selectedState = _states[index];
      });
    }
  }
}
