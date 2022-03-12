import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:file/local.dart';
import 'package:glob/glob.dart';
import 'package:mek_assets/src/build_group/build_group_classes.dart';
import 'package:mek_assets/src/build_group/build_multi_group_node.dart';
import 'package:mek_assets/src/build_group/build_single_group_node.dart';
import 'package:mek_assets/src/settings/settings.dart';
import 'package:mek_assets/src/utils.dart';
import 'package:path/path.dart' as pt;
import 'package:pure_extensions/pure_extensions.dart';

void generateCode(Settings settings) {
  final fileSystem = LocalFileSystem();
  final assets = <String>[];
  final buildGroup = settings.format.fold(single: () {
    return BuildMultiGroupNode(
      fileSystem: LocalFileSystem(),
      options: settings,
    );
  }, multi: () {
    return BuildSingleGroupNode(
      fileSystem: LocalFileSystem(),
      options: settings,
    );
  });
  final buildClasses = BuildGroupClasses(
    settings: settings,
  );

  for (final groupSettings in settings.groups) {
    final outputFileName = '${groupSettings.resolveClassName(settings).snakeCase}.dart';
    final outputDir = groupSettings.resolveOutputDir(settings);
    final outputFile = fileSystem.file(pt.join(outputDir, outputFileName));

    final filePaths = groupSettings.include.expand((glob) {
      return Glob(pt.posix.join(groupSettings.inputDir, glob)).listFileSystemSync(fileSystem);
    }).where((e) {
      return e.statSync().type == FileSystemEntityType.file;
    }).map((file) {
      return file.path.substring(groupSettings.inputDir.length + 3); // ./<PATH>/
    }).toList();

    assets.addAll(filePaths.map((path) => Utils.encodePosixPath(groupSettings.inputDir, path)));
    print(assets);

    if (filePaths.isEmpty) {
      if (outputFile.existsSync()) outputFile.deleteSync();
      continue;
    }

    final root = buildGroup(groupSettings, filePaths);
    final classes = buildClasses(groupSettings, root);

    final library = Library((b) => b..body.addAll(classes));

    final emitter = DartEmitter(useNullSafetySyntax: true);
    final formatter = DartFormatter(pageWidth: settings.pageWidth);
    final rawCode = '// GENERATED CODE - DO NOT MODIFY BY HAND\n\n${library.accept(emitter)}';
    final code = formatter.format(rawCode);

    outputFile.createSync(recursive: true);
    outputFile.writeAsStringSync(code);
  }

  final pubspecFile = fileSystem.file('pubspec.yaml');
  if (pubspecFile.existsSync()) {
    final pubspecContent = pubspecFile.readAsStringSync();

    try {
      final content = Utils.writeInTags(pubspecContent, 'mek_assets', () {
        return assets.map((e) => '    - $e\n').join();
      });
      if (content != null) {
        pubspecFile.writeAsStringSync(content);
      } else {
        lg.w('Not used code generation tags in pubspec.yaml');
      }
    } on InvalidTagsException {
      lg.e('Invalid code generation tags in pubspec.yaml');
      exit(-1);
    }
  } else {
    lg.w('Not exist pubspec.yaml file');
  }

  lg.i('Completed!');
}
