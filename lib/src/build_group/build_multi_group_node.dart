import 'package:file/file.dart';
import 'package:mek_assets/src/build_group/build_group_node.dart';
import 'package:mek_assets/src/settings/settings.dart';
import 'package:path/path.dart' as pt;
import 'package:pure_extensions/pure_extensions.dart';

class BuildMultiGroupNode extends BuildGroupNode {
  BuildMultiGroupNode({
    required Settings options,
    required FileSystem fileSystem,
  }) : super(settings: options, fileSystem: fileSystem);

  @override
  Node call(GroupSettings groupSettings, Iterable<String> filePaths) {
    final root = Node(dirName: groupSettings.resolveClassName(settings));

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
          final newChild = Node(dirName: segment);
          node.children.add(newChild);
          node = newChild;
          continue;
        }

        node = child;
      }
    }

    return root;
  }
}
