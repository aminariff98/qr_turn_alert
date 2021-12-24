import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_turn_alert/models/UserModel.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

class FirebaseUserController {
  Future<void> addUser(uid, fullName, accountType) {
    return users
        .doc(uid)
        .set({
          'uid': uid,
          'fullName': fullName,
          'accountType': accountType,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<UserModel> getUser(userId) async {
    late var body;
    late UserModel userModel;
    FirebaseFirestore.instance.collection('users').doc(userId).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print('Document data: ${documentSnapshot.data()}');
        body = documentSnapshot.data();
        userModel = UserModel(uid: body['uid'], fullName: body['fullName'], accountType: body['accountType']);
        return userModel;
      } else {
        print('Document does not exist on the database');
        return userModel;
      }
    });
    return userModel;
  }
}
