import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../src/models/students_model.dart';

class StudentRepository {
  Future<List<StudentsModel>> findAll() async {
    try {
      final response = await Dio(BaseOptions(baseUrl: 'http://localhost:8080'))
          .get('/students');

      final responseData = response.data;

      return responseData.map<StudentsModel>((student) {
        return StudentsModel.fromMap(student);
      }).toList();
    } on DioError catch (e) {
      throw Exception();
    }
  }

  Future<StudentsModel> findById(int id) async {
    try {
      final response = await Dio(BaseOptions(
              baseUrl: 'http://localhost:8080',
              connectTimeout: Duration(seconds: 10)))
          .get(
        '/students',
        queryParameters: {'id': id},
      );

      if (response.data.isEmpty) {
        throw Exception('Aluno não encontrado');
      }

      return StudentsModel.fromMap(response.data.first);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> insert(StudentsModel students) async {
    try {
      await Dio().post(
        'http://localhost:8080/students',
        data: students.toMap(),
      );
    } on DioError catch (e) {
      throw Exception(e.message);
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
