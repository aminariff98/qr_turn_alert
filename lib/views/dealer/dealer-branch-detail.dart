import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_turn_alert/controller/FirebaseBranchController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/models/BranchModel.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';

class DealerBranchDetail extends StatefulWidget {
  final String id;
  const DealerBranchDetail({Key? key, required this.id}) : super(key: key);

  @override
  _DealerBranchDetailState createState() => _DealerBranchDetailState();
}

class _DealerBranchDetailState extends State<DealerBranchDetail> {
  late final DocumentReference<BranchModel> branchModel;
  late String name, long, lat, state, category, contactNumber, image;

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
          name = data.get('branchName');
          image = data.get('branchImageUrl');
          lat = data.get('branchLat');
          long = data.get('branchLong');
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
                  Image.network('$image'),
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
                    '($lat, $long)',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
                  ),
                  SizedBox(
                    height: userScreenPadding / 3,
                  ),
                  Text(
                    '$name',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
                  ),
                  SizedBox(
                    height: userScreenPadding / 3,
                  ),
                  Text(
                    '$name',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xff163567)),
                  ),
                  SizedBox(
                    height: userScreenPadding / 3,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
