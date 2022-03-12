import 'package:file/file.dart';
import 'package:mek_assets/src/settings/settings.dart';
import 'package:mek_data_class/mek_data_class.dart';

part 'build_group_node.g.dart';

abstract class BuildGroupNode {
  final Settings settings;
  final FileSystem fileSystem;

  BuildGroupNode({
    required this.settings,
    required this.fileSystem,
  });

  Node call(GroupSettings groupSettings, Iterable<String> filePaths);
}

@DataClass()
class Node with _$Node {
  final String dirName;
  final List<String> filePaths;
  final List<Node> children;

  Node({
    required this.dirName,
    List<String>? filePaths,
    List<Node>? children,
  })  : filePaths = filePaths ?? [],
        children = children ?? [];

  R visit<R, T>(R Function(Node node, [T? context]) visitor) {
    return visitor(this);
  }
}
