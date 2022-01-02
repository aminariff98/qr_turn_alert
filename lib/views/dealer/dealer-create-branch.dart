import 'dart:io' as io;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_turn_alert/controller/FirebaseBranchController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qr_turn_alert/views/dealer/dealer-bottom-nav-bar.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:qr_turn_alert/views/widgets/drop-down-list.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterBranch extends StatefulWidget {
  final String additionalUid;
  const RegisterBranch({Key? key, required this.additionalUid}) : super(key: key);

  @override
  _RegisterBranchState createState() => _RegisterBranchState();
}

class _RegisterBranchState extends State<RegisterBranch> {
  String _branchName = '', _branchMsisdn = '', _branchCity = '', _branchState = '', _branchLong = '', _branchLat = '', _branchCategory = '';
  List _states = [
    'Johor',
    'Kedah',
    'Kelantan',
    'Melaka',
    'Negeri Sembilan',
    'Pahang',
    'Perak',
    'Perlis',
    'Pulau Pinang',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu',
    'W.P. Kuala Lumpur',
    'W.P. Labuan',
    'W.P. Putrajaya'
  ];

  List _category = ['Restaurant', 'Bank / Service', 'Restaurant', 'Event', 'Takeaway / Delivery', 'Hospital / Clinic', 'Barber / Salon / Spa'];
  late String downloadURL = '';
  final picker = ImagePicker();
  final _picker = ImagePicker();
  var _branchAttachment;
  List<String> items = ["Camera", "Photo Library"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppNavBarFlat(
          title: 'Branch Information',
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 4.0,
          color: Colors.white,
          margin: EdgeInsets.only(left: userScreenPadding, right: userScreenPadding, top: 15.0, bottom: 15.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context, "branchAttachment");
                        },
                        child: Container(
                          height: userScreenWidth / 2,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.0, color: Colors.transparent),
                            color: Color(0xFFEAF2FA),
                            borderRadius: new BorderRadius.circular(12.0),
                          ),
                          child: ClipRect(
                            child: Center(
                              child: (_branchAttachment == null)
                                  ? Text(
                                      'No image selected.',
                                      style: Theme.of(context).textTheme.bodyText2!.apply(
                                            fontSizeDelta: userTextSize,
                                          ),
                                    )
                                  : Container(
                                      height: userScreenWidth,
                                      child: PhotoView(
                                        initialScale: PhotoViewComputedScale.contained,
                                        minScale: PhotoViewComputedScale.contained,
                                        maxScale: PhotoViewComputedScale.contained,
                                        imageProvider: FileImage(io.File(_branchAttachment.path)),
                                        backgroundDecoration: BoxDecoration(color: Colors.transparent),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _branchName = '';
                      } else {
                        _branchName = value;
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
                  child: TextField(
                    style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      fillColor: Color(0xFFEAF2FA),
                      filled: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                        child: Text(
                          '+60 ',
                          style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                        ),
                      ),
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
                      hintStyle: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                    ),
                    maxLines: 1,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _branchMsisdn = '';
                      } else {
                        _branchMsisdn = value;
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
                        'Category',
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
                          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: '',
                          hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 1,
                        onTap: () {
                          getCategoryDropDownValue(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        '$_branchCategory',
                        style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: userScreenPadding / 2,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Longitude',
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: '',
                      hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _branchLong = '';
                      } else {
                        _branchLong = value;
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
                        'Latitude',
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: '',
                      hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _branchLat = '';
                      } else {
                        _branchLat = value;
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'City',
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: '',
                      hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _branchCity = '';
                      } else {
                        _branchCity = value;
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
                        'State',
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
                          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: '',
                          hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 1,
                        onTap: () {
                          getStateDropDownValue(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        '$_branchState',
                        style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(child: getSubmitButton()),
    );
  }

  getStateDropDownValue(BuildContext context) async {
    var index = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: DropDownList(
            title: 'State',
            items: _states,
            selectedValue: _branchState,
          ),
        );
      },
    );

    if (index != null) {
      setState(() {
        _branchState = _states[index];
      });
    }
  }

  getCategoryDropDownValue(BuildContext context) async {
    var index = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: DropDownList(
            title: 'State',
            items: _category,
            selectedValue: _branchCategory,
          ),
        );
      },
    );

    if (index != null) {
      setState(() {
        _branchCategory = _category[index];
      });
    }
  }

  void _showPicker(context, source) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(userScreenPadding, 0.0, userScreenPadding, userScreenPadding / 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.grey[400],
                          height: 0.3,
                        ),
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTileTheme(
                        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        child: (items[index] == "Photo Library")
                            ? ListTile(
                                leading: new Icon(
                                  Icons.photo_library,
                                  size: 24.0 + userTextSize,
                                  color: Colors.grey[400],
                                ),
                                title: Text(
                                  items[index],
                                  style: TextStyle(fontSize: 14.0 + userTextSize),
                                ),
                                onTap: () {
                                  getImageFromGallery(source);
                                  Navigator.of(context).pop();
                                },
                              )
                            : ListTile(
                                leading: new Icon(
                                  Icons.photo_camera,
                                  size: 24.0 + userTextSize,
                                  color: Colors.grey[400],
                                ),
                                title: Text(
                                  items[index],
                                  style: TextStyle(fontSize: 14.0 + userTextSize),
                                ),
                                onTap: () {
                                  getImageFromCamera(source);
                                  Navigator.of(context).pop();
                                },
                              ),
                      );
                    }),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.only(left: userScreenPadding, right: userScreenPadding, bottom: userScreenPadding),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  title: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0 + userTextSize),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
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
                'Create Branch',
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
          if (_branchName == '' || _branchMsisdn == '' || _branchCity == '' || _branchLong == '' || _branchLat == '' || _branchCategory == '' || _branchState == '') {
            // await Clipboard.setData(ClipboardData(
            //   text: link,
            // ));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Please fill in all of the fields',
                ),
              ),
            );
          } else {
            uploadFile(_branchAttachment);
          }
        },
      ),
    );
  }

  Future<firebase_storage.UploadTask?> uploadFile(XFile? file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));

      return null;
    }

    firebase_storage.UploadTask uploadTask;

    EasyLoading.show();
    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('branch').child('/$uid' + widget.additionalUid + '.jpg');

    _downloadLink(ref);
    final metadata = firebase_storage.SettableMetadata(contentType: 'image/jpeg', customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }

  Future<void> _downloadLink(firebase_storage.Reference ref) async {
    final link = await ref.getDownloadURL();

    _registerBranch(link);
  }

  _registerBranch(_imageUrl) async {
    EasyLoading.dismiss();
    FirebaseBranchController().addBranch(uid, widget.additionalUid, _branchName, '0' + _branchMsisdn, _branchLong, _branchLat, _branchCity, _branchState, _branchCategory, _imageUrl);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DealerBottomNavBar()), (Route<dynamic> route) => false);
  }

  Future getImageFromCamera(source) async {
    var pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    final image = pickedFile;

    setState(() {
      if (image != null) {
        if (source == "branchAttachment") {
          _branchAttachment = image;
        }
      }
    });
  }

  Future getImageFromGallery(source) async {
    var pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    final image = pickedFile;

    setState(() {
      if (image != null) {
        if (source == "branchAttachment") {
          _branchAttachment = image;
        }
      }
    });
  }
}
