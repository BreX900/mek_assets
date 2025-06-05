import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:mek_assets/src/data/fatal_error.dart';

T decodeYamlFile<T>(File file, T Function(Map map) from) {
  if (!file.existsSync()) throw StateException('The ${file.path} not exists.');
  try {
    return checkedYamlDecode(
      file.readAsStringSync(),
      (map) => from(map!),
      sourceUrl: Uri.file(file.path),
    );
  } on ParsedYamlException catch (error) {
    throw StateException(error.formattedMessage!);
  }
}
