// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cli_util/cli_logging.dart' show Ansi;
import 'package:mek_assets/src/assets_generator.dart';
import 'package:mek_assets/src/data/mek_assets_config.dart';
import 'package:mek_assets/src/data/pubspec.dart';
import 'package:mek_assets/src/decode_yaml_file.dart';
import 'package:mek_assets/src/helpers/helper_core.dart';

final _log = _Logger();

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

  final fileSystem = _IoFileSystem();

  final pubspec = await fileSystem.readAsYaml('pubspec.yaml', Pubspec.fromJson);
  final config = pubspec.mekAssets ?? const MekAssetsConfig();

  final generator = AssetsGenerator(fileSystem: fileSystem, pubspec: pubspec, config: config);
  await generator.generate();

  _log.info('> Written assets libraries to "${config.outputPath}"!');
}

class _IoFileSystem extends FileSystem {
  @override
  Future<bool> canRead(String path) async => File(path).existsSync();

  @override
  Future<List<String>> findAssets(String path) async {
    return await Directory(path).list().where((e) => e is File).map((e) => e.path).toList();
  }

  @override
  Future<String> readAsString(String path) async {
    return await File(path).readAsString();
  }

  @override
  Future<void> writeAsString(String path, String contents) async {
    await File(path).writeAsString(contents);
  }
}

class _Logger {
  final _ansi = Ansi(Ansi.terminalSupportsAnsi);

  void verbose(String message) => stdout.writeln(message);

  void error(String message) => stderr.writeln(_ansi.error(message));

  void info(String message) =>
      stdout.writeln(_ansi.emphasized('${_ansi.green}$message${_ansi.none}'));
}
