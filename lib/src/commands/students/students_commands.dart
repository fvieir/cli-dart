import 'package:args/command_runner.dart';
import '../../../repositories/student_repository.dart';
import 'subCommands/find_all_commands.dart';

class StudentsCommands extends Command {
  @override
  String get description => 'Students operations';

  @override
  String get name => 'students';

  StudentsCommands() {
    final repository = StudentRepository();
    addSubcommand(FindAllCommands(repository));
  }
}
