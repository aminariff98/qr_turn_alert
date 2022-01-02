import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_turn_alert/models/BranchModel.dart';

CollectionReference promo = FirebaseFirestore.instance.collection('promotion');

class FirebasePromotionController {
  Future<void> addPromo(uid, id, additionalUid, name, description, referralCode, imageUrl) {
    return promo
        .doc(id + additionalUid)
        .set({
          'uid': uid,
          'branchId': id,
          'id': id + additionalUid,
          'name': name,
          'description': description,
          'referralCode': referralCode,
          'status': 'active',
          'imageUrl': imageUrl,
        })
        .then((value) => print("Promo Added"))
        .catchError((error) => print("Failed to add promo: $error"));
  }

  DocumentReference<BranchModel> getPromo(id) {
    final branchModel = promo.doc(id).withConverter<BranchModel>(
          fromFirestore: (snapshots, _) => BranchModel.fromJson(snapshots.data()!),
          toFirestore: (promo, _) => promo.toJson(),
        );

    return branchModel;
  }

  Future<void> deletePromo(id) {
    return promo
        .doc(id)
        .update({
          'status': 'close',
        })
        .then((value) => print("Promo Updated"))
        .catchError((error) => print("Failed to update promo: $error"));
  }

  Future<void> permanenetDeletePromo(id) {
    return promo.doc(id).delete().then((value) => print("Promo Deleted")).catchError((error) => print("Failed to delete promo: $error"));
  }
}
