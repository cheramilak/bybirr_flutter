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
  final String id;
  final String cardNumber;
  final String cardholderName;
  final String valid; // MM/YY format
  final String cvv;
  final String balance;
  final String status;
  final String cardUserId;
  final String customerId;
  final String cardId;
  final BillingAddress? billingAddress;
  final String? last4;
  final DateTime createdAt;
  final DateTime updatedAt;

  VirtualCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardholderName,
    required this.valid,
    required this.cvv,
    required this.balance,
    required this.status,
    required this.cardUserId,
    required this.customerId,
    required this.cardId,
    this.billingAddress,
    this.last4,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory: From JSON
  factory VirtualCardModel.fromJson(Map<String, dynamic> json) {
    return VirtualCardModel(
      id: json['id'].toString(),
      cardNumber: json['cardNumber'] ?? json['card_number'].toString(),
      cardholderName: json['cardholder_name'] ?? json['cardName'],
      valid: json['valid'],
      cvv: json['cvv'] ?? json['cvv2'],
      balance: json['balance'].toString(),
      status: json['status'],
      cardUserId: json['cardUserId'],
      customerId: json['customerId'],
      cardId: json['cardId'] ?? json['id'],
      billingAddress: json['billingAddress'] != null
          ? BillingAddress.fromJson(json['billingAddress'])
          : null,
      last4: json['last4'],
      createdAt: DateTime.parse(json['created_at'] ?? json['createdAt']),
      updatedAt: DateTime.parse(json['updated_at'] ?? json['updatedAt']),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card_number': cardNumber,
      'cardholder_name': cardholderName,
      'valid': valid,
      'cvv': cvv,
      'balance': balance,
      'status': status,
      'cardUserId': cardUserId,
      'customerId': customerId,
      'cardId': cardId,
      'billing_address': billingAddress?.toJson(),
      'last4': last4,
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
}
