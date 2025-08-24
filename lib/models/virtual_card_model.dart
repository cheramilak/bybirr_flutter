import 'dart:convert';

class BillingAddress {
  final String city;
  final String state;
  final String street;
  final String country;
  final String zipCode;
  final String countryCode;

  BillingAddress({
    required this.city,
    required this.state,
    required this.street,
    required this.country,
    required this.zipCode,
    required this.countryCode,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) {
    return BillingAddress(
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      street: json['street'] ?? '',
      country: json['country'] ?? '',
      zipCode: json['zipCode'] ?? '',
      countryCode: json['countryCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'state': state,
      'street': street,
      'country': country,
      'zipCode': zipCode,
      'countryCode': countryCode,
    };
  }

  @override
  String toString() {
    return '$street, $city, $state $zipCode, $country';
  }
}

class VirtualCardModel {
  final int id;
  final int userId;
  final String cardNumber;
  final String cardholderName;
  final String valid; // MM/YY format
  final String cvv;
  final double balance;
  final String status;
  final DateTime expiryDate;
  final String cardUserId;
  final String customerId;
  final String cardId;
  final BillingAddress? billingAddress;
  final String? last4;
  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;

  VirtualCardModel({
    required this.id,
    required this.userId,
    required this.cardNumber,
    required this.cardholderName,
    required this.valid,
    required this.cvv,
    required this.balance,
    required this.status,
    required this.expiryDate,
    required this.cardUserId,
    required this.customerId,
    required this.cardId,
    this.billingAddress,
    this.last4,
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
      valid: json['valid'],
      cvv: json['cvv'].toString(),
      balance: json['balance'] is String
          ? double.tryParse(json['balance']) ?? 0.0
          : (json['balance'] as num).toDouble(),
      status: json['status'],
      expiryDate: DateTime.parse(json['expiry_date']),
      cardUserId: json['cardUserId'],
      customerId: json['customerId'],
      cardId: json['cardId'],
      billingAddress: json['billing_address'] != null
          ? BillingAddress.fromJson(json['billing_address'])
          : null,
      last4: json['last4'],
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
      'valid': valid,
      'cvv': cvv,
      'balance': balance,
      'status': status,
      'expiry_date': expiryDate.toIso8601String(),
      'cardUserId': cardUserId,
      'customerId': customerId,
      'cardId': cardId,
      'billing_address': billingAddress?.toJson(),
      'last4': last4,
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

  /// Get formatted expiry date (MM/YY)
  String get formattedExpiryDate {
    return '${expiryDate.month.toString().padLeft(2, '0')}/${expiryDate.year.toString().substring(2)}';
  }

  /// Get masked card number
  String get maskedCardNumber {
    if (cardNumber.length <= 8) return cardNumber;
    return '${cardNumber.substring(0, 4)} **** **** ${cardNumber.substring(cardNumber.length - 4)}';
  }

  /// Check if card is active
  bool get isActive => status.toLowerCase() == 'active';

  /// Check if card is blocked
  bool get isBlocked => status.toLowerCase() == 'blocked';

  /// Check if card is expired
  bool get isExpired => DateTime.now().isAfter(expiryDate);
}
