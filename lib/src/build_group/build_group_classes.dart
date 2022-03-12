import 'package:code_builder/code_builder.dart';
import 'package:mek_assets/src/build_group/build_group_node.dart';
import 'package:mek_assets/src/settings/settings.dart';
import 'package:mek_assets/src/utils.dart';
import 'package:path/path.dart' as pt;
import 'package:pure_extensions/pure_extensions.dart';

class BuildGroupClasses {
  final Settings settings;

  const BuildGroupClasses({
    required this.settings,
  });

  List<Class> call(GroupSettings groupSettings, Node root) {
    List<Class> visitor(Node node, [bool isRoot = false]) {
      return [
        _buildClass(groupSettings, isRoot, node),
        ...node.children.expand(visitor),
      ];
    }

    return visitor(root, true);
  }

  Class _buildClass(GroupSettings groupSettings, bool isStatic, Node node) {
    return Class((b) => b
      ..name = node.dirName.pascalCase
      ..constructors.add(Constructor((b) => b
        ..constant = true
        ..name = '_'))
      ..fields.addAll(node.children.map((child) {
        final reference = Reference(child.dirName.pascalCase);

        return Field((b) => b
          ..static = isStatic
          ..modifier = isStatic ? FieldModifier.constant : FieldModifier.final$
          ..type = reference
          ..name = child.dirName.snakeCase
          ..assignment = isStatic
              ? reference.newInstanceNamed('_', []).code
              : reference.constInstanceNamed('_', []).code);
      }))
      ..fields.addAll(node.filePaths.map((filePath) {
        final assetPath = Utils.encodeAssetPath(settings.package, groupSettings.inputDir, filePath);

        return Field((b) => b
          ..static = isStatic
          ..modifier = isStatic ? FieldModifier.constant : FieldModifier.final$
          ..type = const Reference('String')
          ..name = pt.basenameWithoutExtension(filePath).camelCase
          ..assignment = literalString(assetPath).code);
      })));
  }
}
