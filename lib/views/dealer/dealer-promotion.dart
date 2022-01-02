import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_turn_alert/controller/FirebasePromotionController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/models/PromotionModel.dart';
import 'package:qr_turn_alert/views/dealer/dealer-bottom-nav-bar.dart';
import 'package:qr_turn_alert/views/dealer/dealer-create-promotion.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';
import 'package:qr_turn_alert/views/widgets/promotion-display.dart';

class DealerPromotion extends StatefulWidget {
  final String id;
  DealerPromotion({Key? key, required this.id}) : super(key: key);
  @override
  _DealerPromotionState createState() => _DealerPromotionState();
}

class _DealerPromotionState extends State<DealerPromotion> {
  var promotions = [];
  late int count = 0;
  // ignore: top_level_function_literal_block
  var promotionRef = FirebaseFirestore.instance.collection('promotion').get().then((QuerySnapshot querySnapshot) {});
  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    FirebaseFirestore.instance.collection('promotion').get().then((QuerySnapshot querySnapshot) {
      promotions = querySnapshot.docs;
      querySnapshot.docs.forEach((doc) {
        if (doc["branchId"] == widget.id) {
          count++;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppNavBarFlat(
          title: 'Promotions',
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: userScreenPadding,
          ),
          FutureBuilder(
            future: promotionRef,
            builder: (context, AsyncSnapshot<PromotionModel?> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (promotions.length > 0) {
                  return Column(
                    children: [
                      for (int i = 0; i < promotions.length; i++)
                        if (promotions[i]['branchId'] == widget.id) promotionCard(promotions[i]),
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
                      Padding(
                        padding: EdgeInsets.only(left: userScreenPadding * 2, right: userScreenPadding * 2),
                        child: Center(
                            child: Text(
                          'Opps ! There\'s no promotion yet for this branch',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                      ),
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
            MaterialPageRoute(builder: (context) => CreatePromotion(id: widget.id, additionalId: count.toString())),
          );
        },
        backgroundColor: Color.fromRGBO(173, 31, 97, 1),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget promotionCard(promo) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return new BackdropFilter(filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: confirmDelete(context, promo['id']));
          },
        );
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PromotionDisplay(imageUrl: promo['imageUrl'], title: promo['name'], description: promo['description'], referralCode: promo['referralCode'])),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(promo['imageUrl']),
              SizedBox(
                height: userScreenPadding / 2,
              ),
              Text(
                promo['name'],
                style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget confirmDelete(BuildContext context, id) {
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
                              'You are about to delete this promotion. Do you want to proceed?',
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
                        FirebasePromotionController().deletePromo(id);
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
