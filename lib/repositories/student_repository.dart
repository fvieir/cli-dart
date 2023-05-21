import 'dart:convert';

import 'package:http/http.dart' as http;

import '../src/models/students_model.dart';

class StudentRepository {
  Future<List<StudentsModel>> findAll() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/students'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final responseData = jsonDecode(response.body);

    return responseData.map<StudentsModel>((student) {
      return StudentsModel.fromMap(student);
    }).toList();
  }

  Future<StudentsModel> findById(int id) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    if (response.body == '{}') {
      throw Exception('Aluno não encontrado');
    }

    return StudentsModel.fromJson(response.body);
  }

  Future<void> insert(StudentsModel students) async {
    Map<String, String> headers = {
      "content-Type": "application/json",
      "accept": "application/json",
    };

    final response = await http.post(
      Uri.parse('http://localhost:8080/students'),
      body: students.toJson(),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> update(StudentsModel students) async {
    Map<String, String> headers = {
      "content-Type": "application/json",
      "accept": "application/json",
    };

    final response = await http.put(
      Uri.parse('http://localhost:8080/students/${students.id}'),
      body: students.toJson(),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:8080/students/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
