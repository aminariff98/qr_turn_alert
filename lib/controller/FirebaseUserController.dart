import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_turn_alert/models/UserModel.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

class FirebaseUserController {
  Future<void> addUser(uid, fullName, accountType, contactNumber, email) {
    return users
        .doc(uid)
        .set({
          'uid': uid,
          'fullName': fullName,
          'accountType': accountType,
          'msisdn': contactNumber,
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  DocumentReference<UserModel> getUser(userId) {
    final userModel = users.doc(userId).withConverter<UserModel>(
          fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
          toFirestore: (user, _) => user.toJson(),
        );

    return userModel;
  }

  Future<void> updateUser(uid, fullName, contactNumber) {
    return users
        .doc(uid)
        .update({
          'fullName': fullName,
          'msisdn': contactNumber,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> deleteUser(uid) {
    return users.doc(uid).delete().then((value) => print("User Deleted")).catchError((error) => print("Failed to delete user: $error"));
  }
}
