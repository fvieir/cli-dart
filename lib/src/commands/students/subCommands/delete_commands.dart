import 'package:args/command_runner.dart';
import '../../../../repositories/student_repository.dart';
import '../../../models/students_model.dart';

class DeleteCommands extends Command {
  final StudentRepository repository;

  DeleteCommands(this.repository) {
    argParser.addOption('id', abbr: 'i', help: 'id the students');
  }

  @override
  String get description => 'Remove students by Id';

  @override
  String get name => 'deleteById';

  @override
  void run() async {
    var resultId = argResults?['id'];

    if (resultId == null) {
      print('Informe um ID');
      return;
    }

    var id = int.parse(resultId);
    StudentsModel? students;

    try {
      students = await repository.findById(id);
    } on Exception catch (e) {
      print(e);
      return;
    }

    if (students.name.isNotEmpty) {
      print('Removendo aluno ${students.name}...');
      try {
        repository.deleteById(id);

        print('Aluno removido com sucesso!');
      } catch (e) {
        print('Algo deu errado $e');
      }
    }
  }
}
