import 'dart:io';

import 'package:args/command_runner.dart';
import '../../../../repositories/student_repository.dart';

class FindAllCommands extends Command {
  final StudentRepository repository;

  FindAllCommands(this.repository);

  @override
  String get description => 'Find all Students';

  @override
  String get name => 'findAll';

  @override
  void run() async {
    print('Aguarde buscando alunos ...');
    final students = await repository.findAll();
    print('Apresentar também os cursos? (S ou N)?');

    final showCourses = stdin.readLineSync();
    print(showCourses);
  }
}
