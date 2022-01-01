import 'package:flutter/foundation.dart';

@immutable
class BranchModel {
  BranchModel({
    required this.branchName,
    required this.branchMsisdn,
    required this.branchLong,
    required this.branchLat,
    required this.branchState,
    required this.branchCategory,
    required this.branchImageUrl,
  });

  // BranchModel.fromJson(Map<String, Object?> json)
  //     : this(
  //         branchName: json['branchName']! as String,
  //         branchMsisdn: json['branchMsisdn']! as String,
  //         branchLong: json['branchLong']! as String,
  //         branchLat: json['branchLat']! as String,
  //         branchState: json['branchState']! as String,
  //         branchCategory: json['branchCategory']! as String,
  //         branchImageUrl: json['branchImageUrl']! as String,
  //       );

  BranchModel.fromJson(Map<String, Object?> json)
      : this(
          branchName: json['branchName']! as String,
          branchMsisdn: json['branchMsisdn']! as String,
          branchLong: json['branchLong']! as String,
          branchLat: json['branchLat']! as String,
          branchState: json['branchState']! as String,
          branchCategory: json['branchCategory']! as String,
          branchImageUrl: json['branchImageUrl']! as String,
        );

  final String branchName;
  final String branchMsisdn;
  final String branchLong;
  final String branchLat;
  final String branchState;
  final String branchCategory;
  final String branchImageUrl;

  Map<String, Object?> toJson() {
    return {
      'branchName': branchName,
      'branchMsisdn': branchMsisdn,
      'branchLong': branchLong,
      'branchLat': branchLat,
      'branchState': branchState,
      'branchCategory': branchCategory,
      'branchImageUrl': branchImageUrl,
    };
  }
}
