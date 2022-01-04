import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_turn_alert/models/BranchModel.dart';

CollectionReference que = FirebaseFirestore.instance.collection('report');

class FirebaseReportController {
  Future<void> addQue(uid, id, name, date, time, day, month, year) {
    return que
        .doc('$uid-$id-$date')
        .set({
          'uid': uid,
          'branchId': id,
          'queId': '$uid-$id-$date',
          'name': name,
          'date': date,
          'time': time,
          'day': day,
          'month': month,
          'year': year,
          'status': 'completed',
        })
        .then((value) => print("Que Added"))
        .catchError((error) => print("Failed to add que: $error"));
  }

  DocumentReference<BranchModel> getQue(id) {
    final branchModel = que.doc(id).withConverter<BranchModel>(
          fromFirestore: (snapshots, _) => BranchModel.fromJson(snapshots.data()!),
          toFirestore: (que, _) => que.toJson(),
        );

    return branchModel;
  }

  Future<void> updateQue(id) {
    return que
        .doc(id)
        .update({
          'status': 'close',
        })
        .then((value) => print("Que Updated"))
        .catchError((error) => print("Failed to update que: $error"));
  }

  Future<void> permanenetDeleteQue(id) {
    return que.doc(id).delete().then((value) => print("Que Deleted")).catchError((error) => print("Failed to delete que: $error"));
  }
}
