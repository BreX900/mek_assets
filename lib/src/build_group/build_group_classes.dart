import 'package:code_builder/code_builder.dart';
import 'package:mek_assets/src/build_group/build_group_node.dart';
import 'package:mek_assets/src/settings/settings.dart';
import 'package:mek_assets/src/utils.dart';
import 'package:recase/recase.dart';

class BuildGroupClasses {
  final Settings settings;

  const BuildGroupClasses({
    required this.settings,
  });

  List<Class> call(GroupSettings groupSettings, Node root) {
    List<Class> visitor(Node node, [bool isRoot = false]) {
      return [
        _buildClass(groupSettings, isRoot, isRoot, node),
        ...node.children.expand(visitor),
      ];
    }

    return visitor(root, true);
  }

  Class _buildClass(GroupSettings groupSettings, bool isStatic, bool isPublic, Node node) {
    final className = groupSettings.resolveClassName(settings, node.dirName);

    final files = node.files.map((fileName, filePath) {
      final assetPath = Utils.encodeAssetPath(settings.package, groupSettings.inputDir, filePath);
      return MapEntry(fileName, assetPath);
    });

    return Class((b) => b
      ..name = _visibleClass(className, isPublic)
      ..constructors.add(Constructor((b) => b
        ..constant = true
        ..name = '_'))
      ..fields.addAll(node.children.map((child) {
        final className = groupSettings.resolveClassName(settings, child.dirName);
        final reference = Reference(_visibleClass(className, false));

        return Field((b) => b
          ..static = isStatic
          ..modifier = isStatic ? FieldModifier.constant : FieldModifier.final$
          ..type = reference
          ..name = child.dirName.snakeCase
          ..assignment = isStatic
              ? reference.newInstanceNamed('_', []).code
              : reference.constInstanceNamed('_', []).code);
      }))
      ..fields.addAll(files.mapEntries((fileName, assetPath) {
        return Field((b) => b
          ..static = isStatic
          ..modifier = isStatic ? FieldModifier.constant : FieldModifier.final$
          ..type = const Reference('String')
          ..name = fileName
          ..assignment = literalString(assetPath).code);
      }))
      ..fields.addAll([
        if (groupSettings.createMapFiles)
          Field((b) => b
            ..static = true
            ..modifier = FieldModifier.constant
            ..type = TypeReference((b) => b
              ..symbol = 'Map'
              ..types.addAll([const Reference('String'), const Reference('String')]))
            ..name = '\$files'
            ..assignment = literalMap(files).code)
      ]));
  }

  String _visibleClass(String className, bool isPublic) => '${isPublic ? '' : '_'}$className';
}
