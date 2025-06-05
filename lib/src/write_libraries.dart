import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:mek_assets/src/data/dto.dart';
import 'package:mek_assets/src/decode_yaml_file.dart';
import 'package:path/path.dart';

Future<void> writeLibraries(MekAssetsDto config, Map<String, Library> libraries) async {
  final outputDirectory = Directory(config.outputDirectory);
  if (!outputDirectory.existsSync()) outputDirectory.createSync(recursive: true);

  final emitter = DartEmitter(useNullSafetySyntax: true);

  final optionsFile = File('analysis_options.yaml');
  final options = optionsFile.existsSync()
      ? decodeYamlFile(optionsFile, AnalysisOptionsDto.fromJson)
      : const AnalysisOptionsDto();

  final formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
    pageWidth: options.formatter.pageWidth,
  );

  await libraries.entries.map((e) async {
    final MapEntry(key: name, value: library) = e;

    var content = '${library.accept(emitter)}';
    content = formatter.format(content);

    final file = File(join(outputDirectory.path, '$name.dart'));
    await file.writeAsString(content);
  }).wait;
}
