import 'package:alunos_cli/src/commands/students/students_commands.dart';
import 'package:args/command_runner.dart';

void main(List<String> args) {
  CommandRunner('Exemplo CLI', 'Description CLI')
    ..addCommand(StudentsCommands())
    ..run(args);
}
