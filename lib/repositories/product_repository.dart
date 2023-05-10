import 'dart:convert';

import 'package:http/http.dart' as http;
import '../src/models/courses_model.dart';

class ProductRepository {
  Future<CoursesModel> findByName(String name) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/products?name=$name'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final responseData = jsonDecode(response.body);

    if (responseData.isEmpty) {
      throw Exception('Produto não encontrado');
    }

    return CoursesModel.fromMap(responseData.first);
  }
}
