import 'dart:convert';

class CoursesModel {
  final int id;
  final String name;
  bool isStudent;

  CoursesModel({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  // toMap retorna um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isStudent': isStudent,
    };
  }

  // toJson, retorna uma string do model
  String toJson() => jsonEncode(toMap());

  // fromMap recebe um map e retorna um modelo
  factory CoursesModel.fromMap(Map<String, dynamic> map) {
    return CoursesModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      isStudent: map['isStudent'] ?? false,
    );
  }

  // fromJson recebe uma String e decodifica e retorna um map
  factory CoursesModel.fromJson(String json) =>
      CoursesModel.fromMap(jsonDecode(json));

  @override
  String toString() =>
      'CoursesModel(id: $id, name: $name, isStudent: $isStudent)';
}
