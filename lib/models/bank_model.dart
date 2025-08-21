class BankModel {
  final int id;
  final String image;
  final String name;
  final String code;
  final bool status;
  final String uuid;
  final String accountName;
  final String number;

  BankModel({
    required this.id,
    required this.image,
    required this.name,
    required this.code,
    required this.status,
    required this.uuid,
    required this.accountName,
    required this.number,
  });

  /// Convert JSON → Model
  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'],
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      status: json['status'] == 1 || json['status'] == true,
      uuid: json['uuid'],
      accountName: json['accountName'] ?? '',
      number: json['number'] ?? '',
    );
  }
}
