import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../../repositories/product_repository.dart';
import '../../../../repositories/student_repository.dart';
import '../../../models/address_model.dart';
import '../../../models/city_model.dart';
import '../../../models/courses_model.dart';
import '../../../models/phone_model.dart';
import '../../../models/students_model.dart';

class UpdateCommands extends Command {
  final StudentRepository repository;
  final ProductRepository productRepository;

  UpdateCommands(this.repository) : productRepository = ProductRepository() {
    argParser.addOption('file', abbr: 'f', help: 'file the cvs path');
    argParser.addOption('id', abbr: 'i', help: 'ID the user');
  }

  @override
  String get description => 'Update Students';

  @override
  String get name => 'update';

  @override
  void run() async {
    var filePath = argResults?['file'];

    if (filePath == null) {
      print('Por favor informe o caminho do arquivo cvs');
      return;
    }

    final id = argResults?['id'];

    if (id == null) {
      print('Por favor informe o ID do usuário. Exe: -id=0');
      return;
    }

    var students = File(filePath).readAsLinesSync();

    if (students.length != 1) {
      print('Informe apenas um aluno');
      return;
    }

    print('Atualizando ...');

    var student = students.first;
    var studentData = student.split(';');
    var courseFuture = studentData[2].split(',').map((name) async {
      var courses = await productRepository.findByName(name.trim());
      courses.isStudent = true;
      return courses;
    });

    var courses = await Future.wait(courseFuture);

    StudentsModel studentsModel = StudentsModel(
      id: int.parse(id),
      name: studentData[0],
      nameCourses: List.from(studentData[2].split(',')),
      courses: courses,
      address: AddressModel(
        street: studentData[3],
        number: int.parse(studentData[4]),
        zipCode: studentData[5],
        city: CityModel(id: 1, name: studentData[6]),
        phone: PhoneModel(
          ddd: int.parse(studentData[7]),
          phone: studentData[8],
        ),
      ),
    );

    repository.update(studentsModel);

    print('Aluno (${studentsModel.name}) atualizado com sucesso');
  }
}
