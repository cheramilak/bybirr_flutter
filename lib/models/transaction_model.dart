import 'dart:convert';

class TransactionModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? amount;
  final String? centAmount;
  final String? cardBalanceAfter;
  final String? type;
  final String? method;
  final String? narrative;
  final String? status;
  final String? currency;
  final String? reference;
  final String? transactionType;
  final String? cardId;
  final String? authorizationTransactionId;
  final String? settlementTransactionId;

  TransactionModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.amount,
    this.centAmount,
    this.cardBalanceAfter,
    this.type,
    this.method,
    this.narrative,
    this.status,
    this.currency,
    this.reference,
    this.transactionType,
    this.cardId,
    this.authorizationTransactionId,
    this.settlementTransactionId,
  });

  /// Factory: From JSON
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      amount: json['amount'],
      centAmount: json['centAmount'],
      cardBalanceAfter: json['cardBalanceAfter'],
      type: json['type'],
      method: json['method'],
      narrative: json['narrative'],
      status: json['status'],
      currency: json['currency'],
      reference: json['reference'],
      transactionType: json['transactionType'],
      cardId: json['cardId'],
      authorizationTransactionId: json['authorizationTransactionId'],
      settlementTransactionId: json['settlementTransactionId'],
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'amount': amount,
      'centAmount': centAmount,
      'cardBalanceAfter': cardBalanceAfter,
      'type': type,
      'method': method,
      'narrative': narrative,
      'status': status,
      'currency': currency,
      'reference': reference,
      'transactionType': transactionType,
      'cardId': cardId,
      'authorizationTransactionId': authorizationTransactionId,
      'settlementTransactionId': settlementTransactionId,
    };
  }

  /// For converting list of transactions from JSON
  static List<TransactionModel> listFromJson(String str) =>
      List<TransactionModel>.from(
        json.decode(str).map((x) => TransactionModel.fromJson(x)),
      );

  /// For encoding list of transactions to JSON
  static String listToJson(List<TransactionModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  /// Get formatted amount with currency
  String get formattedAmount {
    if (amount == null) return 'N/A';
    final currencySymbol = _getCurrencySymbol();
    return '$currencySymbol${amount}';
  }

  /// Get formatted cent amount
  String get formattedCentAmount {
    if (centAmount == null) return 'N/A';
    final currencySymbol = _getCurrencySymbol();
    final centValue = (double.tryParse(centAmount ?? '0') ?? 0) / 100;
    return '$currencySymbol${centValue.toStringAsFixed(2)}';
  }

  /// Get formatted balance after transaction
  String get formattedBalanceAfter {
    if (cardBalanceAfter == null) return 'N/A';
    final currencySymbol = _getCurrencySymbol();
    final balance = (double.tryParse(cardBalanceAfter ?? '0') ?? 0) / 100;
    return '$currencySymbol${balance.toStringAsFixed(2)}';
  }

  /// Get currency symbol
  String _getCurrencySymbol() {
    switch (currency?.toLowerCase()) {
      case 'usd':
        return '\$';
      case 'eur':
        return '€';
      case 'gbp':
        return '£';
      case 'jpy':
        return '¥';
      default:
        return currency?.toUpperCase() ?? '';
    }
  }

  /// Check if transaction is credit
  bool get isCredit => type?.toLowerCase() == 'credit';

  /// Check if transaction is debit
  bool get isDebit => type?.toLowerCase() == 'debit';

  /// Check if transaction is successful
  bool get isSuccessful => status?.toLowerCase() == 'success';

  /// Check if transaction is pending
  bool get isPending => status?.toLowerCase() == 'pending';

  /// Check if transaction is failed
  bool get isFailed => status?.toLowerCase() == 'failed';

  /// Check if transaction is a top-up
  bool get isTopUp => method?.toLowerCase() == 'topup';

  /// Check if transaction is a spend
  bool get isSpend => method?.toLowerCase() == 'spend';

  /// Check if transaction is a refund
  bool get isRefund => method?.toLowerCase() == 'refund';

  /// Get transaction method display name
  String get methodDisplayName {
    switch (method?.toLowerCase()) {
      case 'topup':
        return 'Top-up';
      case 'spend':
        return 'Purchase';
      case 'refund':
        return 'Refund';
      case 'withdrawal':
        return 'Withdrawal';
      default:
        return method ?? 'Unknown';
    }
  }

  /// Get transaction type display name
  String get typeDisplayName {
    switch (type?.toLowerCase()) {
      case 'credit':
        return 'Credit';
      case 'debit':
        return 'Debit';
      default:
        return type ?? 'Unknown';
    }
  }

  /// Get transaction status display name
  String get statusDisplayName {
    switch (status?.toLowerCase()) {
      case 'success':
        return 'Successful';
      case 'pending':
        return 'Pending';
      case 'failed':
        return 'Failed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status ?? 'Unknown';
    }
  }

  /// Get formatted date
  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  /// Get formatted time
  String get formattedTime {
    return '${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}';
  }

  /// Get relative time (e.g., "2 hours ago")
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  /// Get transaction icon based on method
  String get transactionIcon {
    switch (method?.toLowerCase()) {
      case 'topup':
        return '💰';
      case 'spend':
        return '💳';
      case 'refund':
        return '↩️';
      case 'withdrawal':
        return '💸';
      default:
        return '📊';
    }
  }

  /// Get transaction color based on type
  int get transactionColor {
    if (isCredit) return 0xFF4CAF50; // Green for credit
    if (isDebit) return 0xFFF44336; // Red for debit
    return 0xFF9E9E9E; // Grey for unknown
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, amount: $amount, method: $method, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
