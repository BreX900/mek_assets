// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cli_util/cli_logging.dart' show Ansi;
import 'package:mek_assets/src/build_libraries.dart';
import 'package:mek_assets/src/data/dto.dart';
import 'package:mek_assets/src/data/fatal_error.dart';
import 'package:mek_assets/src/decode_yaml_file.dart';
import 'package:mek_assets/src/find_entities.dart';
import 'package:mek_assets/src/write_libraries.dart';

final _log = Logger();

void main() async {
  try {
    await _main();
  } on StateException catch (exception) {
    _log.error(exception.message);
    exit(-1);
  }
}

Future<void> _main() async {
  _log.verbose('Finding assets...');

  final pubspec = decodeYamlFile(File('pubspec.yaml'), PubspecDto.fromJson);

  final entities = await findEntities(pubspec.flutter.assets);

  final libraries = buildLibraries(pubspec.mekAssets, entities);

  _log.verbose('Found ${libraries.length} assets libraries: ${libraries.keys.join(', ')}');

  await writeLibraries(pubspec.mekAssets, libraries);

  _log.info(
      '> Written ${libraries.length} assets libraries to "${pubspec.mekAssets.outputDirectory}"!');
}

class Logger {
  final _ansi = Ansi(Ansi.terminalSupportsAnsi);

  void verbose(String message) => stdout.writeln(message);

  void error(String message) => stderr.writeln(_ansi.error(message));

  void info(String message) =>
      stdout.writeln(_ansi.emphasized('${_ansi.green}$message${_ansi.none}'));
}
