import 'dart:io' as io;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_turn_alert/controller/FirebasePromotionController.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qr_turn_alert/views/dealer/dealer-promotion.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CreatePromotion extends StatefulWidget {
  final String id;
  final String additionalId;
  const CreatePromotion({Key? key, required this.id, required this.additionalId}) : super(key: key);

  @override
  _CreatePromotionState createState() => _CreatePromotionState();
}

class _CreatePromotionState extends State<CreatePromotion> {
  String _name = '', _description = '', _referralCode = '';

  late String downloadURL = '';
  final picker = ImagePicker();
  final _picker = ImagePicker();
  var _promotionAttachment;
  List<String> items = ["Camera", "Photo Library"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppNavBarFlat(
          title: 'Promotion Information',
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
                              child: (_promotionAttachment == null)
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
                                        imageProvider: FileImage(io.File(_promotionAttachment.path)),
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
                        'Description',
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _description = '';
                      } else {
                        _description = value;
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
                        'Referral Code',
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Optional',
                      hintStyle: Theme.of(context).textTheme.bodyText2!.apply(color: Color(0xFF9D9E9E), fontSizeDelta: userTextSize),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _referralCode = '';
                      } else {
                        _referralCode = value;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(child: getSubmitButton()),
    );
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
                'Create Promotion',
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
          if (_name == '' || _description == '') {
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
            uploadFile(_promotionAttachment);
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
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('promotion').child('/' + widget.id + widget.additionalId + '.jpg');

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
    EasyLoading.dismiss();
    FirebasePromotionController().addPromo(uid, widget.id, widget.additionalId, _name, _description, _referralCode, link);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DealerPromotion(id: widget.id)),
    );
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
          _promotionAttachment = image;
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
          _promotionAttachment = image;
        }
      }
    });
  }
}
