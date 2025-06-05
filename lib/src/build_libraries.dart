import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:mek_assets/src/data/dto.dart';
import 'package:mek_assets/src/data/entity.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

Map<String, Library> buildLibraries(MekAssetsDto config, List<SystemEntity> entities) {
  final libraries = <String, Library>{};
  final singleAssets = <String>[];

  for (final entity in entities) {
    final assetConfig = config.assets[entity.path] ?? const MekAssetDto();
    if (!assetConfig.generate) continue;

    switch (entity) {
      case DirectoryEntity():
        final name = assetConfig.outputClass ?? basename(entity.path).pascalCase;
        libraries[name.snakeCase] =
            _createAssetsLibrary(name, entity.children, fieldRename: _FieldRename.basename);

      case FileEntity():
        singleAssets.add(entity.path);
    }
  }

  final fallbackClassName = config.outputFilesClass;
  if (fallbackClassName != null && singleAssets.isNotEmpty) {
    libraries[fallbackClassName.snakeCase] =
        _createAssetsLibrary(fallbackClassName, singleAssets, fieldRename: _FieldRename.path);
  }

  return libraries;
}

Library _createAssetsLibrary(String name, Iterable<String> paths,
    {required _FieldRename fieldRename}) {
  return Library((b) => b
    ..generatedByComment = 'GENERATED CODE - DO NOT MODIFY BY HAND\n\n'
    ..body.add(Class((b) => b
      ..abstract = true
      ..modifier = ClassModifier.final$
      ..name = name
      ..fields.addAll(paths.map((path) {
        return Field((b) => b
          ..static = true
          ..modifier = FieldModifier.constant
          ..type = const Reference('String')
          ..name = switch (fieldRename) {
            _FieldRename.path => split(withoutExtension(path)).join('_').camelCase,
            _FieldRename.basename => basenameWithoutExtension(path).camelCase,
          }
          ..assignment = literalString(path).code);
      }).sortedBy((field) {
        return field.name;
      })))));
}

enum _FieldRename { basename, path }
