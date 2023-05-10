import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../../repositories/student_repository.dart';

class FindByIdCommands extends Command {
  final StudentRepository repository;

  FindByIdCommands(this.repository);

  @override
  String get description => 'find by id Students';

  @override
  String get name => 'findById';

  @override
  void run() async {
    print('Buscando aluno por id...');
    print('---------------------------------------');
    print('Informe o ID:');
    var id = stdin.readLineSync();

    if (id!.isEmpty) {
      print('Por padrão vamos buscar o ID: 0');
      id = '0';
    }

    var student = await repository.findById(id);

    print('---------------------------------------');
    print('Aluno');
    print('---------------------------------------');
    print(
        '${student.id} - ${student.name} ${student.courses.where((element) => element.isStudent).toList().map((e) => e.name)} ');
  }
}
