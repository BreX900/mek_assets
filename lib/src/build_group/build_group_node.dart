import 'package:file/file.dart';
import 'package:mek_assets/src/settings/settings.dart';

abstract class BuildGroupNode {
  final Settings settings;
  final FileSystem fileSystem;

  BuildGroupNode({
    required this.settings,
    required this.fileSystem,
  });

  List<Node> call(GroupSettings groupSettings, Iterable<String> filePaths);
}

class Node {
  final String dirName;

  /// <FileName, FilePath>
  final Map<String, String> files;
  final List<Node> children;

  Node({
    this.dirName = '.',
    Map<String, String>? files,
    List<Node>? children,
  })  : files = files ?? {},
        children = children ?? [];

  R visit<R, T>(R Function(Node node, [T? context]) visitor) => visitor(this);
}
