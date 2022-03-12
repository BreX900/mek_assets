import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:glob/glob.dart';
import 'package:mek_generate_assets/src/build_group/build_multi_class_group.dart';
import 'package:mek_generate_assets/src/options.dart';
import 'package:mek_generate_assets/src/utils.dart';
import 'package:path/path.dart' as pt;
import 'package:pure_extensions/pure_extensions.dart';

void generateCode(Options options) {
  final fileSystem = LocalFileSystem();

  final pubspecFile = fileSystem.file('pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    throw 'Not exist pubspec.yaml file';
  }

  final pubspecContent = pubspecFile.readAsStringSync();

  final wildcardRefExp = RegExp(r'([ ]+# generated_code)');

  final wildcardMatches = wildcardRefExp.allMatches(pubspecContent);
  if (!(wildcardMatches.isEmpty || wildcardMatches.length == 2)) {
    throw 'Invalid pubspec wildcard';
  }

  final assets = <String>[];

  for (final groupOptions in options.groups) {
    final outputFileName = '${groupOptions.resolveClassName(options).snakeCase}.dart';
    final outputFile = fileSystem.file(pt.join(groupOptions.outputDir, outputFileName));

    final filePaths = groupOptions.paths.expand((e) {
      return Glob(e).listFileSystemSync(fileSystem);
    }).where((e) {
      return e.statSync().type == FileSystemEntityType.file;
    }).map((e) {
      return Utils.encodeAssetPath(e.path);
    }).toList();

    assets.addAll(filePaths);

    if (filePaths.isEmpty) {
      if (outputFile.existsSync()) outputFile.deleteSync();
      continue;
    }

    final classes = BuildMultiClassGroup(
      fileSystem: LocalFileSystem(),
      options: options,
    )(groupOptions, filePaths);

    final library = Library((b) => b..body.addAll(classes));

    final emitter = DartEmitter(useNullSafetySyntax: true);
    final formatter = DartFormatter(pageWidth: options.pageWidth);
    final rawCode = '${library.accept(emitter)}';
    final code = formatter.format(rawCode);

    outputFile.writeAsStringSync(code);
  }

  if (wildcardMatches.isNotEmpty) {
    final startWildcardMatch = wildcardMatches.first;
    final endWildcardMatch = wildcardMatches.last;

    final startGeneratedCode = startWildcardMatch.end;
    final endGeneratedCode = endWildcardMatch.start;
    print('$startGeneratedCode -> $endGeneratedCode');

    final previous = pubspecContent.substring(0, startGeneratedCode);
    final next = pubspecContent.substring(endGeneratedCode);

    pubspecFile.writeAsStringSync(previous);
    pubspecFile.writeAsStringSync(next);
  }
}
