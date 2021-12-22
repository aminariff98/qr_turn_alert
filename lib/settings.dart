import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_turn_alert/Screens/Welcome/welcome_screen.dart';
import 'package:qr_turn_alert/analysispage.dart';
import 'package:qr_turn_alert/analysispage1.dart';
import 'package:qr_turn_alert/constants.dart';
import 'package:qr_turn_alert/generate.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  CreateAlertDialog(BuildContext context) {

    TextEditingController customController = TextEditingController();

    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to logout from your account?'
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WelcomeScreen()),

                );
              }
          ),
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              }
          ),
        ],
      );
    } );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 28, top: 7),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/Profile.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Muhammad Haris Fahmi", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Business Account',
                          style: TextStyle(
                            color: Colors.white,

                          ),)
                        ],
                      ),
                    )
                  ],
                )

              ),
            ]
          ),

          Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(34)
                    )
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Settings",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(
                        height: 15,
                        thickness: 2,
                      ),
                      buildAccountOptionRow(context, "Account"),
                      buildAccountOptionRow(context, "General"),
                      buildAccountOptionRow(context, "Language"),
                      buildAccountOptionRow(context, "Privacy and security"),
                      buildAccountOptionRow1(context, "Setup Queue"),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.volume_up_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Notifications",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(
                        height: 15,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildNotificationOptionRow("Enable Notification", true),

                      SizedBox(
                        height: 10,
                      ),
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
                                child: Text("                                  Logout                                                  ", style: const TextStyle(
                                  color: Colors.white,)),
                                onPressed: () {
                                  /*Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => WelcomeScreen()));*/
                                  CreateAlertDialog(context);
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),

                                )
                            )
                        ),
                      ),

                    ],
                  ),
                ),
              ),
          ),



        ],
      ),
    );
  }

          /*Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
              children: [
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Account",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
          ]
                Row(
                  children: [
                    SizedBox(
                      width: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Material(
                          color: kPrimaryColor,
                          elevation: 14,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: Color(0x802196F3),
                          child: FlatButton(
                              height: 50,
                              padding: EdgeInsets.all(0.0),
                              child: Text("                                         View Analytics                                   ", style: const TextStyle(
                                color: Colors.white,)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AnalysisPage1()),

                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),

                              )
                          )
                      ),
                    ),
                  ],
                ),
                buildAccountOptionRow(context, "View Analytics"),
                buildAccountOptionRow(context, "Social"),
                buildAccountOptionRow(context, "Language"),
                buildAccountOptionRow(context, "Privacy and security"),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.volume_up_outlined,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Notifications",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                buildNotificationOptionRow("New for you", true),
                buildNotificationOptionRow("Account activity", true),
                buildNotificationOptionRow("Opportunity", false),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Text("SIGN OUT",
                        style: TextStyle(
                            fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),*/


  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow1(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow1(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Generate()),
          //QueueDetails()),

        );
        //_ModalBottomSheet(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}