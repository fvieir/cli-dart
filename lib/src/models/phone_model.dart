import 'dart:convert';

class PhoneModel {
  final int ddd;
  final String phone;

  PhoneModel({
    required this.ddd,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'ddd': ddd,
      'phone': phone,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory PhoneModel.fromMap(Map<String, dynamic> map) {
    return PhoneModel(
      ddd: map['ddd'] ?? 0,
      phone: map['phone'] ?? '',
    );
  }

  factory PhoneModel.fromJson(String json) {
    return PhoneModel.fromMap(jsonDecode(json));
  }

  @override
  String toString() {
    return 'PhoneModel(ddd: $ddd, phone: $phone)';
  }
}
