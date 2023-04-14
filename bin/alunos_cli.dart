import 'package:args/command_runner.dart';

void main(List<String> args) {
  CommandRunner('Exemplo CLI', 'Description CLI')
    ..addCommand(ExemploComand())
    ..run(args);
}

class ExemploComand extends Command {
  ExemploComand() {
    argParser.addOption('template', abbr: 't', help: 'Template de criação');
    argParser.addOption('name', abbr: 'n', help: 'Insera nome');
    argParser.addFlag('data', abbr: 'd', help: 'Listar flags');
  }

  @override
  String get description => 'Exemplo de comando';

  @override
  String get name => 'exemplo';

  @override
  void run() {
    print(argResults?['template']);
    print(argResults?['name']);
    print(argResults?['data']);
    print('teste');
  }
}
