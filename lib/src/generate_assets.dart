import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:file/local.dart';
import 'package:glob/glob.dart';
import 'package:mek_assets/src/build_group/build_group_classes.dart';
import 'package:mek_assets/src/build_group/build_multi_group_node.dart';
import 'package:mek_assets/src/build_group/build_single_group_node.dart';
import 'package:mek_assets/src/build_group/build_tree_group_node.dart';
import 'package:mek_assets/src/settings/settings.dart';
import 'package:mek_assets/src/utils.dart';
import 'package:path/path.dart' as pt;

void generateCode(Settings settings) {
  final fileSystem = LocalFileSystem();
  var assets = <String>[];
  final buildGroup = settings.format.fold(single: () {
    return BuildSingleGroupNode(
      fileSystem: LocalFileSystem(),
      options: settings,
    );
  }, multi: () {
    return BuildMultiGroupNode(
      fileSystem: LocalFileSystem(),
      options: settings,
    );
  }, tree: () {
    return BuildTreeGroupNode(
      fileSystem: LocalFileSystem(),
      options: settings,
    );
  });
  final buildClasses = BuildGroupClasses(
    settings: settings,
  );

  for (final groupSettings in settings.groups) {
    final outputFile = fileSystem.file(groupSettings.resolveOutputFile(settings));

    var filePaths = groupSettings.include.expand((glob) {
      return Glob(pt.posix.join(groupSettings.inputDir, glob)).listFileSystemSync(fileSystem);
    }).where((e) {
      return e.statSync().type == FileSystemEntityType.file && !e.basename.startsWith('.');
    }).map((file) {
      return file.path.substring(groupSettings.inputDir.length + 3); // ./<PATH>/
    }).toList();
    filePaths = [...filePaths]..sort();

    if (filePaths.isEmpty) {
      if (outputFile.existsSync()) outputFile.deleteSync();
      continue;
    }

    assets.addAll(filePaths.map((path) => Utils.encodePosixPath(groupSettings.inputDir, path)));
    print(assets);

    final roots = buildGroup(groupSettings, filePaths);
    final classes = roots.expand((root) => buildClasses(groupSettings, root));

    final library = Library((b) => b..body.addAll(classes));

    final emitter = DartEmitter(useNullSafetySyntax: true);
    final formatter = DartFormatter(pageWidth: settings.pageWidth);
    final rawCode = '// GENERATED CODE - DO NOT MODIFY BY HAND\n\n'
        '// ignore_for_file: library_private_types_in_public_api\n\n'
        '${library.accept(emitter)}';
    final code = formatter.format(rawCode);

    outputFile.createSync(recursive: true);
    outputFile.writeAsStringSync(code);
  }

  final pubspecFile = fileSystem.file('pubspec.yaml');
  if (pubspecFile.existsSync()) {
    final pubspecContent = pubspecFile.readAsStringSync();

    try {
      assets = [...assets]..sort();
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
