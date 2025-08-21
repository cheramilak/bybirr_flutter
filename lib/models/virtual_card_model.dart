import 'dart:convert';

class VirtualCardModel {
  final int id;
  final int userId;
  final String cardNumber;
  final String cardholderName;
  final String expirationDate; // MM/YY format
  final String cvv;
  final double balance;
  final String status; // Active, Inactive, Blocked
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;

  VirtualCardModel({
    required this.id,
    required this.userId,
    required this.cardNumber,
    required this.cardholderName,
    required this.expirationDate,
    required this.cvv,
    required this.balance,
    required this.status,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory: From JSON
  factory VirtualCardModel.fromJson(Map<String, dynamic> json) {
    return VirtualCardModel(
      id: json['id'],
      userId: json['user_id'],
      cardNumber: json['card_number'].toString(),
      cardholderName: json['cardholder_name'],
      expirationDate: json['expiration_date'],
      cvv: json['cvv'].toString(),
      balance: json['balance'] is String
          ? double.tryParse(json['balance']) ?? 0.0
          : (json['balance'] as num).toDouble(),
      status: json['status'],
      uuid: json['uuid'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'card_number': cardNumber,
      'cardholder_name': cardholderName,
      'expiration_date': expirationDate,
      'cvv': cvv,
      'balance': balance,
      'status': status,
      'uuid': uuid,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// For converting list of cards from JSON
  static List<VirtualCardModel> listFromJson(String str) =>
      List<VirtualCardModel>.from(
        json.decode(str).map((x) => VirtualCardModel.fromJson(x)),
      );

  /// For encoding list of cards to JSON
  static String listToJson(List<VirtualCardModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
