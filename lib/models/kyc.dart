class KYCModel {
  final String fName;
  final String lName;
  final String country;
  final String idType;
  final String idNumber;
  final String phone;
  final String city;
  final String address;
  final String zipCode;
  final String line1;
  final String houseNumber;
  final String photo;
  final String idFront;
  final String idBack;
  final String email;
  final DateTime bod;
  final String status;
  final String? reason;
  final String? customerId;

  KYCModel({
    required this.fName,
    required this.lName,
    this.country = "Ethiopia",
    this.idType = "PASSPORT",
    required this.idNumber,
    required this.phone,
    required this.city,
    required this.address,
    required this.zipCode,
    required this.line1,
    required this.houseNumber,
    required this.photo,
    required this.idFront,
    required this.idBack,
    required this.email,
    required this.bod,
    this.status = "Pending",
    this.reason,
    this.customerId,
  });

  factory KYCModel.fromJson(Map<String, dynamic> json) {
    return KYCModel(
      fName: json['fName'],
      lName: json['lName'],
      country: json['country'] ?? "Ethiopia",
      idType: json['idType'] ?? "PASSPORT",
      idNumber: json['idNumber'],
      phone: json['phone'],
      city: json['city'],
      address: json['address'],
      zipCode: json['zipCode'],
      line1: json['line1'],
      houseNumber: json['houseNumber'],
      photo: json['photo'],
      idFront: json['idFront'],
      idBack: json['idBack'],
      email: json['email'],
      bod: DateTime.parse(json['bod']),
      status: json['status'] ?? "Pending",
      reason: json['reason'],
      customerId: json['customerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fName': fName,
      'lName': lName,
      'country': country,
      'idType': idType,
      'idNumber': idNumber,
      'phone': phone,
      'city': city,
      'address': address,
      'zipCode': zipCode,
      'line1': line1,
      'houseNumber': houseNumber,
      'photo': photo,
      'idFront': idFront,
      'idBack': idBack,
      'email': email,
      'bod': bod.toIso8601String(),
      'status': status,
      'reason': reason,
      'customerId': customerId,
    };
  }
}
