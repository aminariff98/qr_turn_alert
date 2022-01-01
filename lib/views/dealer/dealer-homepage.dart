import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_turn_alert/controller/FirebaseBranchController.dart';
import 'package:qr_turn_alert/controller/FirebaseUserController.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/models/BranchModel.dart';
import 'package:qr_turn_alert/models/UserModel.dart';
import 'package:qr_turn_alert/prequeue.dart';
import 'package:qr_turn_alert/views/dealer/dealer-bottom-nav-bar.dart';
import 'package:qr_turn_alert/views/dealer/dealer-branch-detail.dart';
import 'package:qr_turn_alert/views/dealer/dealer-create-branch.dart';

class DealerHomepage extends StatefulWidget {
  final fullName;
  DealerHomepage({
    Key? key,
    this.fullName,
  }) : super(key: key);
  @override
  _DealerHomepageState createState() => _DealerHomepageState();
}

class _DealerHomepageState extends State<DealerHomepage> {
  var branches = [];
  late int count = 0;
  late final DocumentReference<UserModel> userModel;
  // ignore: top_level_function_literal_block
  var branchRef = FirebaseFirestore.instance.collection('branch').get().then((QuerySnapshot querySnapshot) {});
  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    userModel = FirebaseUserController().getUser(uid);
    FirebaseFirestore.instance.collection('branch').get().then((QuerySnapshot querySnapshot) {
      branches = querySnapshot.docs;
      querySnapshot.docs.forEach((doc) {
        if (doc["uid"] == uid) {
          count++;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        elevation: 0,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.radio_button_off_rounded,
              color: kPrimaryColor,
              size: 10,
            ),
            padding: const EdgeInsets.only(right: 15),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PreQueuePage()),
              );
            },
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          StreamBuilder<DocumentSnapshot<UserModel>>(
            stream: userModel.snapshots(),
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
              fullName = data.get('fullName');

              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Text("Welcome $fullName", textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              );
            },
          ),
          SizedBox(
            height: userScreenPadding,
          ),
          FutureBuilder(
            future: branchRef,
            builder: (context, AsyncSnapshot<BranchModel?> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (branches.length > 0) {
                  return Column(
                    children: [
                      for (int i = 0; i < branches.length; i++)
                        if (branches[i]['uid'] == uid) branchCard(branches[i]),
                      SizedBox(
                        height: userScreenPadding / 2,
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: userScreenHeight * 0.35,
                      ),
                      Center(
                          child: Text(
                        'Opps ! There\'s no branch yet',
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                    ],
                  );
                }
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterBranch(
                      additionalUid: count.toString(),
                    )),
          );
        },
        backgroundColor: Color.fromRGBO(173, 31, 97, 1),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget branchCard(branch) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return new BackdropFilter(filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: confirmReset(context, branch['branchUid']));
          },
        );
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DealerBranchDetail(
                    id: branch['branchUid'],
                  )),
        );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(branch['branchImageUrl']),
              SizedBox(
                height: userScreenPadding / 2,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(text: 'Name:\n', style: Theme.of(context).textTheme.bodyText1!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize)),
                    TextSpan(
                      text: branch['branchName'],
                      style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: userScreenPadding / 2,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(text: 'Contact Number:\n', style: Theme.of(context).textTheme.bodyText1!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize)),
                    TextSpan(
                      text: branch['branchMsisdn'],
                      style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: userScreenPadding / 2,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(text: 'Location:\n', style: Theme.of(context).textTheme.bodyText1!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize)),
                    TextSpan(
                      text: '(' + branch['branchLat'] + ', ' + branch['branchLong'] + ')',
                      style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: userScreenPadding / 2,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(text: 'State:\n', style: Theme.of(context).textTheme.bodyText1!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize)),
                    TextSpan(
                      text: branch['branchState'],
                      style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget confirmReset(BuildContext context, id) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Color(0xffF3F6FB),
          margin: EdgeInsets.fromLTRB(userScreenPadding * 2, userScreenPadding / 2, userScreenPadding * 2, userScreenPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ListTile(
                enabled: false,
                contentPadding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 16.0),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: userScreenPadding,
                            ),
                            Text(
                              'Are you sure?',
                              style: Theme.of(context).textTheme.bodyText1!.apply(
                                    fontSizeDelta: 4,
                                  ),
                            ),
                            SizedBox(
                              height: userScreenPadding,
                            ),
                            Text(
                              'You are about to delete this branch. Do you want to proceed?',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2!.apply(fontSizeDelta: 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                onTap: () {},
              ),
              Divider(
                color: Color(0xFF9D9E9E),
                indent: 0,
                endIndent: 0,
                height: 1,
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            width: 0.5,
                            color: Color(0xFF9D9E9E),
                          ),
                        ),
                      ),
                      child: ListTile(
                        minVerticalPadding: 14,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(20.0)),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Center(
                            child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: 0),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      minVerticalPadding: 14,
                      onTap: () {
                        EasyLoading.show();
                        FirebaseBranchController().deleteBranch(id);
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DealerBottomNavBar()), (Route<dynamic> route) => false);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(bottomRight: const Radius.circular(20.0)),
                      ),
                      title: Center(
                        child: Text(
                          'Delete',
                          style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: (0)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}