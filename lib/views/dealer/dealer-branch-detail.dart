import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_turn_alert/controller/FirebaseBranchController.dart';
import 'package:qr_turn_alert/generate.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/models/BranchModel.dart';
import 'package:qr_turn_alert/views/dealer/dealer-branch-report.dart';
import 'package:qr_turn_alert/views/dealer/dealer-manage-que.dart';
import 'package:qr_turn_alert/views/dealer/dealer-promotion.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';

class DealerBranchDetail extends StatefulWidget {
  final String id;
  const DealerBranchDetail({Key? key, required this.id}) : super(key: key);

  @override
  _DealerBranchDetailState createState() => _DealerBranchDetailState();
}

class _DealerBranchDetailState extends State<DealerBranchDetail> {
  late final DocumentReference<BranchModel> branchModel;
  late String id, name, long, lat, city, state, category, contactNumber, image;

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    branchModel = FirebaseBranchController().getBranch(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<BranchModel>>(
        stream: branchModel.snapshots(),
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
          id = data.get('branchUid');
          name = data.get('branchName');
          image = data.get('branchImageUrl');
          lat = data.get('branchLat');
          long = data.get('branchLong');
          city = data.get('branchCity');
          state = data.get('branchState');
          category = data.get('branchCategory');
          contactNumber = data.get('branchMsisdn');

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: AppNavBarFlat(
                title: '$name',
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    '$image',
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: userScreenPadding / 2,
                  ),
                  Text(
                    '$name',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
                  ),
                  SizedBox(
                    height: userScreenPadding / 3,
                  ),
                  Text(
                    '$contactNumber',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
                  ),
                  SizedBox(
                    height: userScreenPadding / 3,
                  ),
                  Text(
                    '$city, $state',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
                  ),
                  SizedBox(
                    height: userScreenPadding / 3,
                  ),
                  Text(
                    '$category',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
                  ),
                  SizedBox(
                    height: userScreenPadding / 3,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(userScreenPadding, userScreenPadding / 2, userScreenPadding, userScreenPadding / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DealerPromotion(
                                            id: id.toString(),
                                          )),
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: userScreenWidth * 0.02, top: userScreenWidth * 0.02),
                                    child: Image(
                                      image: AssetImage('assets/icons/branch/promotion.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    height: (userScreenWidth * 0.25),
                                    width: (userScreenWidth * 0.25),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: userScreenWidth * 0.02),
                                    child: Text(
                                      'Promotion',
                                      style: Theme.of(context).textTheme.subtitle1!.apply(fontWeightDelta: 2, fontSizeDelta: userTextSize),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 4.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DealerBranchReport(branchId: id)),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: userScreenWidth * 0.02, top: userScreenWidth * 0.02),
                                    child: Image(
                                      image: AssetImage('assets/icons/branch/report.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    height: (userScreenWidth * 0.25),
                                    width: (userScreenWidth * 0.25),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: userScreenWidth * 0.02),
                                    child: Text(
                                      'Report',
                                      style: Theme.of(context).textTheme.subtitle1!.apply(fontWeightDelta: 2, fontSizeDelta: userTextSize),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 4.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BranchQrCode(id: id)),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: userScreenWidth * 0.02, top: userScreenWidth * 0.02),
                                    child: Image(
                                      image: AssetImage('assets/icons/branch/qr-code.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    height: (userScreenWidth * 0.25),
                                    width: (userScreenWidth * 0.25),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: userScreenWidth * 0.02),
                                    child: Text(
                                      'Qr Code',
                                      style: Theme.of(context).textTheme.subtitle1!.apply(fontWeightDelta: 2, fontSizeDelta: userTextSize),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(userScreenPadding, 0, userScreenPadding, userScreenPadding / 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DealerManageBranch(branchId: id)),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: userScreenWidth * 0.02, top: userScreenWidth * 0.02),
                                    child: Image(
                                      image: AssetImage('assets/icons/branch/qr-code.png'),
                                      fit: BoxFit.contain,
                                    ),
                                    height: (userScreenWidth * 0.25),
                                    width: (userScreenWidth * 0.25),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: userScreenWidth * 0.02),
                                    child: Text(
                                      'Manage',
                                      style: Theme.of(context).textTheme.subtitle1!.apply(fontWeightDelta: 2, fontSizeDelta: userTextSize),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
