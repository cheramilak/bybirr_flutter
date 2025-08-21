class RateModel {
  final int id;
  final double rate;
  final double max;
  final double min;
  final String status; // "Active" or "Block"

  RateModel({
    required this.id,
    required this.rate,
    required this.max,
    required this.min,
    required this.status,
  });

  /// Convert JSON → Model
  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      id: json['id'],
      rate: double.tryParse(json['rate'].toString()) ?? 0.0,
      max: double.tryParse(json['max'].toString()) ?? 0.0,
      min: double.tryParse(json['min'].toString()) ?? 0.0,
      status: json['status'] ?? 'Active',
    );
  }

  /// Convert Model → JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'rate': rate, 'max': max, 'min': min, 'status': status};
  }
}
