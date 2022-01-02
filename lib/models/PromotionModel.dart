import 'package:flutter/foundation.dart';

@immutable
class PromotionModel {
  PromotionModel({
    required this.uid,
    required this.id,
    required this.branchId,
    required this.name,
    required this.description,
    required this.referralCode,
    required this.status,
    required this.imageUrl,
  });

  PromotionModel.fromJson(Map<String, Object?> json)
      : this(
          uid: json['uid']! as String,
          id: json['id']! as String,
          branchId: json['branchId']! as String,
          name: json['name']! as String,
          description: json['description']! as String,
          referralCode: json['referralCode']! as String,
          status: json['status']! as String,
          imageUrl: json['imageUrl']! as String,
        );

  final String uid;
  final String id;
  final String branchId;
  final String name;
  final String description;
  final String referralCode;
  final String status;
  final String imageUrl;

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'id': id,
      'branchId': branchId,
      'name': name,
      'description': description,
      'referralCode': referralCode,
      'status': status,
      'imageUrl': imageUrl,
    };
  }
}
