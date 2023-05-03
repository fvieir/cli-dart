import 'dart:convert';

import 'address_model.dart';
import 'courses_model.dart';

class StudentsModel {
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<CoursesModel> courses;
  final AddressModel address;

  StudentsModel({
    this.id,
    required this.name,
    this.age,
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
      'courses': courses.map((course) => course.toMap()).toList(),
      'adress': address.toMap(),
    };
  }

  // toJson, retorna uma string do model
  String toJson() => jsonEncode(toMap());

  // fromMap recebe um map e retorna um modelo
  factory StudentsModel.fromMap(Map<String, dynamic> map) {
    return StudentsModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'],
      nameCourses: List.from(map['nameCourses'] ?? <String>[]),
      courses: map['courses']
              ?.map((courseMap) => CoursesModel.fromMap(courseMap))
              .toList() ??
          <CoursesModel>[],
      address: AddressModel.fromMap(map['address'] ?? <String, dynamic>{}),
    );
  }

  // fromJson recebe uma String e decodifica e retorna um map
  factory StudentsModel.fromJson(String json) =>
      StudentsModel.fromMap(jsonDecode(json));
}
