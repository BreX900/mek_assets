import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:mek_assets/src/data/mek_assets_config.dart';
import 'package:mek_assets/src/data/system_entity.dart';
import 'package:mek_assets/src/helpers/helper_core.dart';
import 'package:path/path.dart';
import 'package:recase/recase.dart';

mixin LibrariesBuilderHelper on HelperCore {
  /// Returns Library<name, code>
  Library buildLibrary(List<SystemEntity> entities) {
    final classes = <Class>[];
    final singleAssets = <String>[];

    for (final entity in entities) {
      final assetConfig = config.assets[entity.path] ?? const MekAssetConfig();
      if (!assetConfig.generate) continue;

      switch (entity) {
        case DirectoryEntity():
          final class$ = _createClass(
            assetConfig.outputClass ?? basename(entity.path).pascalCase,
            entity.children,
            fieldRename: _FieldRename.basename,
          );
          classes.add(class$);

        case FileEntity():
          singleAssets.add(entity.path);
      }
    }

    final fallbackClassName = config.outputFilesClass;
    if (fallbackClassName != null && singleAssets.isNotEmpty) {
      final class$ = _createClass(fallbackClassName, singleAssets, fieldRename: _FieldRename.path);
      classes.add(class$);
    }

    return _createLibrary(classes);
  }

  Library _createLibrary(Iterable<Spec> body) {
    return Library(
      (b) => b
        ..generatedByComment =
            'GENERATED CODE - DO NOT MODIFY BY HAND\n\n'
            '// **************************************************************************\n'
            '// Generate by MekAssets package: https://pub.dev/packages/mek_assets\n'
            '// **************************************************************************\n'
            '\n'
        ..body.addAll(body),
    );
  }

  Class _createClass(String name, Iterable<String> paths, {required _FieldRename fieldRename}) {
    return Class(
      (b) => b
        ..abstract = true
        ..modifier = ClassModifier.final$
        ..name = name
        ..fields.addAll(
          paths
              .map((path) {
                return Field(
                  (b) => b
                    ..static = true
                    ..modifier = FieldModifier.constant
                    ..type = const Reference('String')
                    ..name = switch (fieldRename) {
                      _FieldRename.path => split(withoutExtension(path)).join('_').camelCase,
                      _FieldRename.basename => basenameWithoutExtension(path).camelCase,
                    }
                    ..assignment = literalString(path).code,
                );
              })
              .sortedBy((field) {
                return field.name;
              }),
        ),
    );
  }
}

enum _FieldRename { basename, path }
