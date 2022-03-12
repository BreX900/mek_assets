import 'package:code_builder/code_builder.dart';
import 'package:file/file.dart';
import 'package:mek_generate_assets/src/build_group/build_group.dart';
import 'package:mek_generate_assets/src/options.dart';
import 'package:pure_extensions/pure_extensions.dart';

class BuildSingleGroup extends BuildGroup {
  BuildSingleGroup({
    required Options options,
    required FileSystem fileSystem,
  }) : super(options: options, fileSystem: fileSystem);

  @override
  List<Class> call(GroupOptions groupOptions, Iterable<String> filePaths) {
    return [
      Class((b) => b
        ..name = groupOptions.resolveClassName(options)
        ..fields.addAll(filePaths.map((filePath) {
          return Field((b) => b
            ..static = true
            ..modifier = FieldModifier.constant
            ..type = const Reference('String')
            ..name = filePath.replaceAll(pt.current, '_').camelCase
            ..assignment = literalString(filePath).code);
        }))),
    ];
  }
}
