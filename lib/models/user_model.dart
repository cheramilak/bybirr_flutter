import 'package:bybirr_flutter/models/kyc.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String status;
  KYCModel? kycModel;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.status,
    this.kycModel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      status: json['status'],
      kycModel: KYCModel.fromJson(json['kyc']),
    );
  }
}
