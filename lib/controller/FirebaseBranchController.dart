import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_turn_alert/models/BranchModel.dart';

CollectionReference branch = FirebaseFirestore.instance.collection('branch');

class FirebaseBranchController {
  Future<void> addBranch(uid, additionalUid, branchName, branchMsisdn, branchLong, branchLat, branchCity, branchState, branchCategory, branchImageUrl) {
    return branch
        .doc(uid + additionalUid)
        .set({
          'uid': uid,
          'branchUid': uid + additionalUid,
          'branchName': branchName,
          'branchMsisdn': branchMsisdn,
          'branchLong': branchLong,
          'branchLat': branchLat,
          'branchCity': branchCity,
          'branchState': branchState,
          'branchCategory': branchCategory,
          'branchImageUrl': branchImageUrl,
        })
        .then((value) => print("Branch Added"))
        .catchError((error) => print("Failed to add branch: $error"));
  }

  DocumentReference<BranchModel> getBranch(id) {
    final branchModel = branch.doc(id).withConverter<BranchModel>(
          fromFirestore: (snapshots, _) => BranchModel.fromJson(snapshots.data()!),
          toFirestore: (branch, _) => branch.toJson(),
        );

    return branchModel;
  }

  Future<void> updateBranch(uid, branchName, branchMsisdn, branchLong, branchLat, branchCity, branchState, branchCategory) {
    return branch
        .doc(uid)
        .update({
          'branchName': branchName,
          'branchMsisdn': branchMsisdn,
          'branchLong': branchLong,
          'branchLat': branchLat,
          'branchCity': branchCity,
          'branchState': branchState,
          'branchCategory': branchCategory,
        })
        .then((value) => print("Branch Updated"))
        .catchError((error) => print("Failed to update branch: $error"));
  }

  Future<void> deleteBranch(id) {
    return branch.doc(id).delete().then((value) => print("Branch Deleted")).catchError((error) => print("Failed to delete branch: $error"));
  }
}
