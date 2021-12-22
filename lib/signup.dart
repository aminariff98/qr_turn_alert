// import 'package:barcode_scan2/barcode_scan2.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_turn_alert/covid19customappbar.dart';
// import 'package:qr_turn_alert/constants.dart';
// import 'package:qr_turn_alert/covid19screens.dart';
// import 'package:qr_turn_alert/nav.dart';
// import 'package:qr_turn_alert/prequeue.dart';
// import 'dart:math';

// import 'queuing_detail_page.dart';

// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   String qrResult = "Not yet Scanned";
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(""),
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: kPrimaryColor,
//         automaticallyImplyLeading: false,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.settings,
//               color: kPrimaryColor,
//               size: 30,
//             ),
//             padding: const EdgeInsets.only(right: 15),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PreQueuePage()),
//                 //QueueDetails()),
//               );
//               //_ModalBottomSheet(context);
//             },
//           )
//         ],
//       ),
//       /*body: CustomScrollView(
//         physics: ClampingScrollPhysics(),
//         slivers: <Widget>[
//           _buildHeader(screenHeight),
//         ]
//       ),*/
//       body: ListView(
//         scrollDirection: Axis.vertical,
//         children: <Widget>[
//           Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: kPrimaryColor,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(40),
//                   bottomRight: Radius.circular(40),
//                 ),
//               ),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
//                 Row(
//                   children: <Widget>[Text("Greetings Haris.", style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))],
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 Text("Welcome to VQueue.", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
//               ])),
//           SizedBox(height: 10),
//           Container(
//               margin: const EdgeInsets.symmetric(
//                 vertical: 10,
//                 horizontal: 10,
//               ),
//               padding: const EdgeInsets.all(10),
//               height: screenHeight * 0.15,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFAD9FE4), kPrimaryLightColor],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
//                 Row(
//                   children: <Widget>[Text("Experience virtual queuing", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))],
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 Text("Be part of the queue without your physical presence. Easily scan the QR code and start queuing.",
//                     style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
//               ])),
//           SizedBox(height: 0),
//           Container(
//               margin: const EdgeInsets.symmetric(
//                 vertical: 10,
//                 horizontal: 10,
//               ),
//               padding: const EdgeInsets.all(10),
//               height: screenHeight * 0.15,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFAD9FE4), kPrimaryLightColor],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
//                 Row(
//                   children: <Widget>[Text("Received all the latest details", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))],
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 Text("Get all the latest queuing details from your phone while you're away.", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
//               ])),
//           SizedBox(height: 0),
//           Container(
//               margin: const EdgeInsets.symmetric(
//                 vertical: 10,
//                 horizontal: 10,
//               ),
//               padding: const EdgeInsets.all(10),
//               height: screenHeight * 0.15,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFAD9FE4), kPrimaryLightColor],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
//                 Row(
//                   children: <Widget>[Text("Get notified", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))],
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 Text("Receive notification when it is almost your turn.", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
//               ])),
//           /*Text("   Get notified",  style: const TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight:
//               FontWeight.bold)),
//           SizedBox(height: screenHeight * 0.02),
//           Text("   Receive notification when it is almost your turn.",  style: const TextStyle(
//             color: Colors.black,
//             fontSize: 15,
//           )),*/
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Material(
//                 color: kPrimaryColor,
//                 elevation: 14,
//                 borderRadius: BorderRadius.circular(10),
//                 shadowColor: Color(0x802196F3),
//                 child: FlatButton(
//                     height: 50,
//                     padding: EdgeInsets.all(15.0),
//                     child: Text("Click here to queue",
//                         style: const TextStyle(
//                           color: Colors.white,
//                         )),
//                     onPressed: () async {
//                       String scanning = (await BarcodeScanner.scan()) as String;
//                       qrResult = scanning;
//                       print(qrResult);

//                       if (qrResult == scanning) {
//                         print("Hello");
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => PreQueuePage()),
//                         );
//                       }
//                     },
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ))),
//           ),
//         ],
//       ),
//     );

//     Future scan() async {
//       String barcode = (await BarcodeScanner.scan()) as String;
//       Navigator.pushNamed(context, '/scanResult');
//     }
//   }

//   Widget myDetailsContainer1() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: Container(
//               child: Text(
//             "Click here to begin scanning",
//             style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0, fontWeight: FontWeight.bold),
//           )),
//         ),
//       ],
//     );
//   }

//   SliverToBoxAdapter _buildHeader(double screenHeight) {
//     return SliverToBoxAdapter(
//         child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: kPrimaryColor,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(40),
//                 bottomRight: Radius.circular(40),
//               ),
//             ),
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
//               Row(
//                 children: <Widget>[Text("Greetings Haris.", style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))],
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               Text("Hello and welcome to VQueue."),
//             ])));
//   }

//   Widget flatButton(String text, Widget widget) {
//     return FlatButton(
//       padding: EdgeInsets.all(15.0),
//       height: 150,
//       child: Text(text),
//       onPressed: () {
//         Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
//       },
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//         side: BorderSide(color: Colors.blue, width: 3.0),
//       ),
//     );
//   }

//   void _ModalBottomSheet(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return Container(
//             height: 800, //MediaQuery.of(context).size.height * .95,
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Text("                  Maybank Suria KLCC", textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [Text("Address: C-21-C, Petronas Twin Tower Expansion, Jalan \nAmpang, Kuala Lumpur City Centre 50088 Kuala Lumpur, \nWilayah Persekutuan Kuala Lumpur")],
//                   ),
//                   SizedBox(
//                     height: 285,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: Material(
//                       color: kPrimaryColor,
//                       elevation: 14,
//                       borderRadius: BorderRadius.circular(10),
//                       shadowColor: Color(0x802196F3),
//                       child: ElevatedButton(
//                         child: Text("                                           Join Queue                                           ",
//                             style: const TextStyle(
//                               color: Colors.white,
//                             )),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => PreQueuePage()),
//                             //QueueDetails()),
//                           );
//                           _incrementPosition();
//                           DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("QueuePosition");
//                           _testRef.set("Hello World ${Random().nextInt(100)}");
//                         },
//                         // shape: RoundedRectangleBorder(
//                         //   borderRadius: BorderRadius.circular(10.0),
//                         // ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/maybank-klcc.jpg'),
//               ),
//             ),
//           );
//         });
//   }

//   void _incrementPosition() {
//     DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("QueuePosition");
//     _testRef.set("Hello World ${Random().nextInt(100)}");
//   }
// }

// /*String location;
// String date;
// String time;
// int QueuePosition;*/
