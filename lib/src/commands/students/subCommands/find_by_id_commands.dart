import 'package:args/command_runner.dart';
import '../../../../repositories/student_repository.dart';

class FindByIdCommands extends Command {
  final StudentRepository repository;

  FindByIdCommands(this.repository) {
    argParser.addOption('id', abbr: 'i', help: 'Buscar Students por ID');
  }

  @override
  String get description => 'find by id Students';

  @override
  String get name => 'ById';

  @override
  void run() async {
    print('Buscando aluno por id...');
    print('---------------------------------------');

    var result = argResults?['id'];

    if (result == null || result.isEmpty) {
      print('Por favor informe o ID. Exe: Byid --id=0');
      return;
    }

    var id = int.parse(result);
    var student = await repository.findById(id);

    print('---------------------------------------');
    print('Aluno');
    print('---------------------------------------');
    print(
        '${student.id} - ${student.name} ${student.courses.where((element) => element.isStudent).toList().map((e) => e.name)} ');
  }
}
