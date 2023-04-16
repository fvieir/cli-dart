import 'dart:convert';

class CityModel {
  final int id;
  final String name;

  CityModel({
    required this.id,
    required this.name,
  });

  // toMap retorna um Map<String, dynaminc>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // toJson, retorna uma string do model
  String toJson() => jsonEncode(toMap());

  // fromMap recebe um map e retorna um modelo

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'],
      name: map['name'],
    );
  }

  // fromJson recebe uma String e decodifica e retorna um map
  factory CityModel.fromJson(String json) =>
      CityModel.fromMap(jsonDecode(json));
}
