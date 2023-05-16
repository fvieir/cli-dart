import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../../repositories/product_repository.dart';
import '../../../../repositories/student_repository.dart';
import '../../../models/address_model.dart';
import '../../../models/city_model.dart';
import '../../../models/phone_model.dart';
import '../../../models/students_model.dart';

class InsertCommands extends Command {
  final StudentRepository repository;
  final ProductRepository productRepository;

  InsertCommands(this.repository) : productRepository = ProductRepository() {
    argParser.addOption('file', abbr: 'f', help: 'path of the csv file');
  }

  @override
  String get description => 'Insert Students';

  @override
  String get name => 'insert';

  @override
  void run() async {
    print('Aguarde lendo arquivo .........');
    var path = argResults?['file'];
    var students = File(path).readAsLinesSync();
    print('----------------------------------------');

    for (var student in students) {
      var studentsData = student.split(';');

      var coursesFuture = studentsData[2].split(',').map((e) async {
        var courses = await productRepository.findByName(e.trim());
        courses.isStudent = true;
        return courses;
      }).toList();

      var courses = await Future.wait(coursesFuture);

      final students = StudentsModel(
        name: studentsData[0],
        age: int.tryParse(studentsData[1]),
        nameCourses: studentsData[2].split(',').map((e) => e.trim()).toList(),
        courses: courses,
        address: AddressModel(
          street: studentsData[3],
          number: int.parse(studentsData[4]),
          zipCode: studentsData[5],
          city: CityModel(id: 1, name: studentsData[6]),
          phone: PhoneModel(
            ddd: int.parse(studentsData[7]),
            phone: studentsData[8],
          ),
        ),
      );

      try {
        await repository.insert(students);
        print('Inserido com sucesso estudante: ${students.name}');
      } catch (e) {
        print('Erro ao inserir aluno : ${students.name}! \n Mensagem => $e');
      }
    }

    print('Fim');
  }
}
