import 'dart:convert';

import 'city_model.dart';
import 'phone_model.dart';

class AddressModel {
  final String street;
  final int number;
  final String zipCode;
  final CityModel city;
  final PhoneModel phone;

  AddressModel({
    required this.street,
    required this.number,
    required this.zipCode,
    required this.city,
    required this.phone,
  });

  // toMap retorna um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'zipCode': zipCode,
      'city': city.toMap(),
      'phone': phone.toMap(),
    };
  }

  // toJson, retorna uma string do model
  String toJson() => jsonEncode(toMap());

  // fromMap recebe um map e retorna um modelo
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      street: map['street'] ?? '',
      number: map['number'] ?? 0,
      zipCode: map['zipCode'] ?? '',
      city: CityModel.fromMap(map['city'] ?? <String, dynamic>{}),
      phone: PhoneModel.fromMap(map['phone'] ?? <String, dynamic>{}),
    );
  }

  // fromJson recebe uma String e decodifica e retorna um map
  factory AddressModel.fromJson(String json) =>
      AddressModel.fromMap(jsonDecode(json));

  @override
  String toString() {
    return 'AddressModel(street: $street, number: $number, zipCode: $zipCode, city: $city, phone: $phone)';
  }
}
