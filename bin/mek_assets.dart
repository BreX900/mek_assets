import 'dart:io';

import 'package:args/args.dart';
import 'package:checked_yaml/checked_yaml.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:mek_assets/mek_assets.dart';
import 'package:mek_assets/src/utils.dart';

final argsParser = ArgParser()
  ..addOption('settings', abbr: 's', valueHelp: 'Define a yaml file path.')
  ..addFlag('verbose', abbr: 'v', defaultsTo: false, help: 'Print more logs')
  ..addFlag('help', abbr: 'h', defaultsTo: false, negatable: false)
  ..addCommand('build', ArgParser());

final toolBox = ToolBox(name: 'mek_assets');

void main(List<String> rawArgs) async {
  final args = argsParser.parse(rawArgs);
  final settingsPath = args['settings'] as String?;
  final canVerbose = args['verbose'] as bool;
  final askHelp = args['help'] as bool;

  if (args.command?.name != 'build' || askHelp) {
    lg.stdout('Global options:');
    lg.stdout(argsParser.usage);
    lg.stdout('');
    lg.stdout('Available commands:');
    argsParser.commands.forEach((command, _) {
      lg.stdout('  $command    Generate a assets dart class and flutter entries.');
    });
    exit(0);
  }
  if (canVerbose) lg = Logger.verbose();

  final settingsFile = toolBox.findYaml(settingsPath);
  final yamlSettings = ToolBox.loadYaml(settingsFile, YamlSettings.fromJson);
  final settings = yamlSettings.mekAssets;

  await generateCode(settings);
}

class ToolBox {
  final File projectYaml = File('pubspec.yaml');
  final File packageYaml;

  ToolBox({required String name}) : packageYaml = File('$name.yaml');

  File findYaml(String? path) {
    if (path != null) return File(path);

    if (packageYaml.existsSync()) return packageYaml;

    return projectYaml;
  }

  static T loadYaml<T>(File file, T Function(Map map) from) {
    if (!file.existsSync()) {
      lg.e('Not find ${file.path} file in this project');
      exit(-1);
    }
    try {
      return checkedYamlDecode(
        file.readAsStringSync(),
        (map) => from(map!),
        sourceUrl: Uri.file(file.path),
      );
    } on ParsedYamlException catch (error) {
      lg.e(error.formattedMessage!);
      exit(-1);
    }
  }
}
