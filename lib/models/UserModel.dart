import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  UserModel({
    required this.uid,
    required this.fullName,
    required this.accountType,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          uid: json['uid']! as String,
          fullName: json['fullName']! as String,
          accountType: json['accountType']! as String,
        );

  final String uid;
  final String fullName;
  final String accountType;

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'accountType': accountType,
    };
  }
}
