import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/prequeue.dart';

import 'package:qr_turn_alert/views/customer/customer-branch-category.dart';
import 'package:qr_turn_alert/views/widgets/promotion-display.dart';

class CustomerHomepage extends StatefulWidget {
  @override
  _CustomerHomepageState createState() => _CustomerHomepageState();
}

class _CustomerHomepageState extends State<CustomerHomepage> {
  List notificationCategory = ['Restaurant', 'Bank / Service', 'Event', 'Takeaway / Delivery', 'Hospital / Clinic', 'Barber / Salon / Spa'];
  var promoRef = FirebaseFirestore.instance.collection('promotion').snapshots();

  String qrResult = "Not yet Scanned";
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
          SizedBox(
            height: userScreenPadding,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(userScreenPadding, 0.0, userScreenPadding, userScreenPadding),
            child: Text(
              'Promotions',
              style: Theme.of(context).textTheme.headline6!.apply(
                    fontSizeDelta: userTextSize,
                  ),
            ),
          ),
          StreamBuilder(
            stream: promoRef,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var items = [];
              snapshot.data!.docs.map((DocumentSnapshot doc) {
                items.add(doc);
              }).toList();

              return CarouselSlider(
                options: CarouselOptions(
                  height: userScreenHeight * 0.25,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.831,
                ),
                items: [
                  for (var announcement in items)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PromotionDisplay(
                                  imageUrl: announcement['imageUrl'], title: announcement['name'], description: announcement['description'], referralCode: announcement['referralCode'])),
                        );
                      },
                      child: Hero(
                        tag: announcement['imageUrl'],
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(image: NetworkImage(announcement['imageUrl']), fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          Container(
            padding: EdgeInsets.fromLTRB(userScreenPadding, userScreenPadding, userScreenPadding, 0.0),
            child: Text(
              'Services',
              style: Theme.of(context).textTheme.headline6!.apply(
                    fontSizeDelta: userTextSize,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(userScreenPadding, userScreenPadding / 2, userScreenPadding, userScreenPadding),
            child: Wrap(
              children: [
                for (int index = 0; index < notificationCategory.length; index++)
                  Padding(
                    padding: EdgeInsets.all(userScreenPadding / 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BranchCategory(category: notificationCategory[index])),
                        );
                      },
                      child: Card(
                        elevation: 4.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          width: userScreenWidth * 0.4,
                          height: userScreenWidth * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/icons/services/bank.png'),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                notificationCategory[index],
                                softWrap: true,
                                maxLines: 2,
                                style: TextStyle(fontSize: 15, color: Color(0xff163567), fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Material(
          //       color: kPrimaryColor,
          //       elevation: 14,
          //       borderRadius: BorderRadius.circular(10),
          //       shadowColor: Color(0x802196F3),
          //       child: FlatButton(
          //           height: 50,
          //           padding: EdgeInsets.all(15.0),
          //           child: Text("Click here to queue",
          //               style: const TextStyle(
          //                 color: Colors.white,
          //               )),
          //           onPressed: () async {
          //             String scanning = (await BarcodeScanner.scan()) as String;
          //             qrResult = scanning;
          //             print(qrResult);

          //             if (qrResult == scanning) {
          //               print("Hello");
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(builder: (context) => PreQueuePage()),
          //               );
          //             }
          //           },
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10.0),
          //           ))),
          // ),
        ],
      ),
    );
  }

  Widget info() {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(
                children: <Widget>[Text("Greetings.", style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))],
              ),
              SizedBox(height: userScreenHeight * 0.02),
              Text("Welcome to VQueue.", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            ])),
        SizedBox(height: 10),
        Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            padding: const EdgeInsets.all(10),
            height: userScreenHeight * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFAD9FE4), kPrimaryLightColor],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(
                children: <Widget>[Text("Experience virtual queuing", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))],
              ),
              SizedBox(height: userScreenHeight * 0.02),
              Text("Be part of the queue without your physical presence. Easily scan the QR code and start queuing.",
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ])),
        SizedBox(height: 0),
        Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            padding: const EdgeInsets.all(10),
            height: userScreenHeight * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFAD9FE4), kPrimaryLightColor],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(
                children: <Widget>[Text("Received all the latest details", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))],
              ),
              SizedBox(height: userScreenHeight * 0.02),
              Text("Get all the latest queuing details from your phone while you're away.", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ])),
        SizedBox(height: 0),
        Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            padding: const EdgeInsets.all(10),
            height: userScreenHeight * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFAD9FE4), kPrimaryLightColor],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(
                children: <Widget>[Text("Get notified", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))],
              ),
              SizedBox(height: userScreenHeight * 0.02),
              Text("Receive notification when it is almost your turn.", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ])),
      ],
    );
  }

  Future scan() async {
    String barcode = (await BarcodeScanner.scan()) as String;
    Navigator.pushNamed(context, '/scanResult');
  }

  Widget myDetailsContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Click here to begin scanning",
            style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0, fontWeight: FontWeight.bold),
          )),
        ),
      ],
    );
  }
}
