import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_turn_alert/controller/FirebaseUserController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/models/UserModel.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DealerAccountDetail extends StatefulWidget {
  const DealerAccountDetail({Key? key}) : super(key: key);

  @override
  _DealerAccountDetailState createState() => _DealerAccountDetailState();
}

class _DealerAccountDetailState extends State<DealerAccountDetail> {
  late final DocumentReference<UserModel> userModel;
  late TextEditingController _nameController, _msisdnController;
  late String _name, _msisdn, _accountType, _email;

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    userModel = FirebaseUserController().getUser(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppNavBarFlat(
          title: 'Profile Details',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: userScreenPadding,
            ),
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
                _name = data.get('fullName');
                _msisdn = data.get('msisdn');
                _accountType = data.get('accountType');
                _email = data.get('email');
                _nameController = TextEditingController(text: _name);
                _msisdnController = TextEditingController(text: _msisdn);

                return SingleChildScrollView(
                  child: Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: EdgeInsets.only(left: userScreenPadding, right: userScreenPadding, bottom: 15.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: userScreenPadding / 2,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Name',
                                  style: Theme.of(context).textTheme.bodyText1!.apply(
                                        fontSizeDelta: userTextSize,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: new BoxDecoration(border: Border.all(width: 0.0, color: Colors.transparent), color: Color(0xFFEAF2FA), borderRadius: new BorderRadius.circular(12.0)),
                            child: TextFormField(
                              style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                              cursorColor: Color(0xFF9b9b9b),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: '',
                                hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                              ),
                              controller: _nameController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              maxLines: 1,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  _name = '';
                                } else {
                                  _name = value;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: userScreenPadding / 2,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Contact Number',
                                  style: Theme.of(context).textTheme.bodyText1!.apply(
                                        fontSizeDelta: userTextSize,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: new BoxDecoration(border: Border.all(width: 0.0, color: Colors.transparent), color: Color(0xFFEAF2FA), borderRadius: new BorderRadius.circular(12.0)),
                            child: TextFormField(
                              style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                              cursorColor: Color(0xFF9b9b9b),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: '',
                                hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                              ),
                              controller: _msisdnController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  _msisdn = '';
                                } else {
                                  _msisdn = value;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: userScreenPadding / 2,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Account Type',
                                  style: Theme.of(context).textTheme.bodyText1!.apply(
                                        fontSizeDelta: userTextSize,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                decoration: new BoxDecoration(border: Border.all(width: 0.0, color: Colors.transparent), color: Color(0xFFEAF2FA), borderRadius: new BorderRadius.circular(12.0)),
                                child: TextFormField(
                                  readOnly: true,
                                  style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                                  cursorColor: Color(0xFF9b9b9b),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFFF5F6F7),
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 15.0),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: '',
                                    hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  maxLines: 1,
                                  onTap: () {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  '$_accountType',
                                  style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Email',
                                  style: Theme.of(context).textTheme.bodyText1!.apply(
                                        fontSizeDelta: userTextSize,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                decoration: new BoxDecoration(border: Border.all(width: 0.0, color: Colors.transparent), color: Color(0xFFEAF2FA), borderRadius: new BorderRadius.circular(12.0)),
                                child: TextFormField(
                                  readOnly: true,
                                  style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                                  cursorColor: Color(0xFF9b9b9b),
                                  decoration: InputDecoration(
                                    fillColor: Color(0xFFF5F6F7),
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 15.0),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    hintText: '',
                                    hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  maxLines: 1,
                                  onTap: () {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  '$_email',
                                  style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(child: getSubmitButton()),
    );
  }

  Widget getSubmitButton() {
    return Container(
      padding: EdgeInsets.only(
        left: userScreenWidth / 5,
        right: userScreenWidth / 5,
        bottom: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          textStyle: TextStyle(color: Colors.white),
          padding: EdgeInsets.zero,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            gradient: LinearGradient(
              colors: <Color>[
                Color.fromRGBO(173, 31, 97, 1),
                Color.fromRGBO(70, 0, 106, 1),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30,
              ),
              Text(
                'Update',
                style: Theme.of(context).textTheme.button!.apply(
                      fontSizeDelta: userTextSize,
                      color: Colors.white,
                    ),
              )
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        onPressed: () {
          if (_name == '' || _msisdn == '') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Please fill in all of the fields',
                ),
              ),
            );
          } else {
            updateUser();
          }
        },
      ),
    );
  }

  Future<void> updateUser() async {
    EasyLoading.dismiss();
    fullName = _name;
    FirebaseUserController().updateUser(uid, _name, _msisdn);
    Navigator.pop(context);
  }
}
