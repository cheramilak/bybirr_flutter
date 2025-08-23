import 'package:bybirr_flutter/models/kyc.dart';
import 'package:bybirr_flutter/models/virtual_card_model.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String status;
  final String? emailVerifiedAt;
  KYCModel? kycModel;
  final List<VirtualCardModel> cards;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.status,
    this.kycModel,
    required this.cards,
    this.emailVerifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var list = json['cards'] as List;

    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      status: json['status'],
      kycModel: json['kyc'] != null ? KYCModel.fromJson(json['kyc']) : null,
      emailVerifiedAt: json['email_verified_at'],
      cards: list.map((e) => VirtualCardModel.fromJson(e)).toList(),
    );
  }
}
