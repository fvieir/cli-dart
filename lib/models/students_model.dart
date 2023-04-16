import 'dart:convert';

import 'address_model.dart';
import 'courses_model.dart';

class StudentsModel {
  final int id;
  final String name;
  final int age;
  final List<String> nameCourses;
  final CoursesModel courses;
  final AddressModel address;

  StudentsModel({
    required this.id,
    required this.name,
    required this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  // toMap retorna um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'nameCourses': nameCourses,
      'courses': courses.toMap(),
      'adress': address.toMap(),
    };
  }

  // toJson, retorna uma string do model
  String toJson() => jsonEncode(toMap());

  // fromMap recebe um map e retorna um modelo
  factory StudentsModel.fromMap(Map<String, dynamic> map) {
    return StudentsModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      nameCourses: map['nameCourses'],
      courses: CoursesModel.fromMap(map['courses']),
      address: AddressModel.fromMap(map['address']),
    );
  }

  // fromJson recebe uma String e decodifica e retorna um map
  factory StudentsModel.fromJson(String json) =>
      StudentsModel.fromMap(jsonDecode(json));
}
