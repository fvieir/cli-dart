import 'package:args/command_runner.dart';
import '../../../repositories/student_repository.dart';
import 'subCommands/delete_commands.dart';
import 'subCommands/find_all_commands.dart';
import 'subCommands/find_by_id_commands.dart';
import 'subCommands/insert_commands.dart';
import 'subCommands/update_commands.dart';

class StudentsCommands extends Command {
  @override
  String get description => 'Students operations';

  @override
  String get name => 'students';

  StudentsCommands() {
    final repository = StudentRepository();
    addSubcommand(FindAllCommands(repository));
    addSubcommand(FindByIdCommands(repository));
    addSubcommand(InsertCommands(repository));
    addSubcommand(UpdateCommands(repository));
    addSubcommand(DeleteCommands(repository));
  }
}
