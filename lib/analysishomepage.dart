import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_turn_alert/analysispage.dart';
import 'package:qr_turn_alert/analysispage2.dart';
import 'package:qr_turn_alert/constants.dart';

import 'analysispage1.dart';

class AnalysisHomepage extends StatefulWidget {

  @override
  _AnalysisHomepageState createState() => _AnalysisHomepageState();
}

class _AnalysisHomepageState extends State<AnalysisHomepage> {
  List analytics = [];

  @override
  void initState() {
    super.initState();
    analytics.add("View number of customers per day");
    analytics.add("View number of customers per counter");
    analytics.add("Item3");
    analytics.add("Item4");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics Page'),
        centerTitle: true,
      ),

      /*body: ListView.builder(
        itemCount: analytics.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              key: Key(analytics[index]),
              child: Card(
                elevation: 2,
                  child: ListTile(
                      title: Text(analytics[index]),
                      trailing: IconButton(icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},),
                  )
          )
          );
        },
      ),*/

      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          SizedBox(height: 10),
          SvgPicture.asset(
            "assets/icons/undraw_Analytics.svg",
            height: size.height * 0.3,
            width: size.width * 0.4,
          ),
          SizedBox(height: 30,),
          Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 340,
                color: kPrimaryColor,
                child: Row(
                  children: <Widget>[
                    Text("   View June 2021 Data",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 25,),
                      padding: const EdgeInsets.only(left: 160),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AnalysisPage1()));
                      },
                    )
                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 10,),

          Row(
            children: <Widget>[
              Container(
                height: 50,
                width: 340,
                color: kPrimaryColor,
                child: Row(
                  children: <Widget>[
                    Text("    View July 2021 Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 25,),
                      padding: const EdgeInsets.only(left: 160),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AnalysisPage2()));
                      },
                    )
                  ],
                ),
              ),

            ],
          )
        ],
      )
    );
  }
}
