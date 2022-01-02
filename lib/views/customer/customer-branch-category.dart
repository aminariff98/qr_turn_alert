import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/views/customer/customer-branch-detail.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';

class BranchCategory extends StatefulWidget {
  final String category;
  BranchCategory({Key? key, required this.category}) : super(key: key);
  @override
  _BranchCategoryState createState() => _BranchCategoryState();
}

class _BranchCategoryState extends State<BranchCategory> {
  var branchRef = FirebaseFirestore.instance.collection('branch').snapshots();

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
          StreamBuilder(
              stream: branchRef,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    return branchCard(doc);
                  }).toList(),
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
}
