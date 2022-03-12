import 'package:code_builder/code_builder.dart';
import 'package:file/file.dart';
import 'package:mek_data_class/mek_data_class.dart';
import 'package:mek_generate_assets/src/build_group/build_group.dart';
import 'package:mek_generate_assets/src/options.dart';
import 'package:pure_extensions/pure_extensions.dart';

part 'build_multi_class_group.g.dart';

class BuildMultiClassGroup extends BuildGroup {
  BuildMultiClassGroup({
    required Options options,
    required FileSystem fileSystem,
  }) : super(options: options, fileSystem: fileSystem);

  @override
  List<Class> call(GroupOptions groupOptions, Iterable<String> filePaths) {
    final root = _Node(dirName: groupOptions.resolveClassName(options));

    for (final filePath in filePaths) {
      final segments = pt.split(filePath);
      var node = root;
      for (var i = 0; i < segments.length; i++) {
        final segment = segments[i];

        if ((i + 1) == segments.length) {
          node.filePaths.add(filePath);
          continue;
        }

        final child = node.children.firstWhereOrNull((node) => node.dirName == segment);
        if (child == null) {
          final newChild = _Node(dirName: segment);
          node.children.add(newChild);
          node = newChild;
          continue;
        }

        node = child;
      }
    }

    List<Class> visitor(_Node node, [bool isRoot = false]) {
      return [
        _buildClass(isRoot, node.dirName, node.children.map((e) => e.dirName), node.filePaths),
        ...node.children.expand(visitor),
      ];
    }

    return visitor(root, true);
  }

  Class _buildClass(
    bool isRoot,
    String dirName,
    Iterable<String> children,
    Iterable<String> filePaths,
  ) {
    return Class((b) => b
      ..name = dirName.pascalCase
      ..constructors.add(Constructor((b) => b
        ..constant = true
        ..name = '_'))
      ..fields.addAll(children.map((child) {
        final reference = Reference(child.pascalCase);

        return Field((b) => b
          ..static = isRoot
          ..modifier = isRoot ? FieldModifier.constant : FieldModifier.final$
          ..type = reference
          ..name = child.snakeCase
          ..assignment = isRoot
              ? reference.newInstanceNamed('_', []).code
              : reference.constInstanceNamed('_', []).code);
      }))
      ..fields.addAll(filePaths.map((filePath) {
        return Field((b) => b
          ..static = isRoot
          ..modifier = isRoot ? FieldModifier.constant : FieldModifier.final$
          ..type = const Reference('String')
          ..name = pt.basenameWithoutExtension(filePath).snakeCase
          ..assignment = literalString(filePath).code);
      })));
  }
}

@DataClass()
class _Node with _$_Node {
  final String dirName;
  final List<String> filePaths;
  final List<_Node> children;

  _Node({
    required this.dirName,
    List<String>? filePaths,
    List<_Node>? children,
  })  : filePaths = filePaths ?? [],
        children = children ?? [];

  R visit<R, T>(R Function(_Node node, [T? context]) visitor) {
    return visitor(this);
  }
}
