import 'package:file/file.dart';
import 'package:mek_assets/src/build_group/build_group_node.dart';
import 'package:mek_assets/src/settings/settings.dart';
import 'package:path/path.dart' as pt;
import 'package:pure_extensions/pure_extensions.dart';

class BuildSingleGroupNode extends BuildGroupNode {
  BuildSingleGroupNode({
    required Settings options,
    required FileSystem fileSystem,
  }) : super(settings: options, fileSystem: fileSystem);

  @override
  List<Node> call(GroupSettings groupSettings, Iterable<String> filePaths) {
    final root = Node(
      files: {
        for (final filePath in filePaths)
          pt
              .join(pt.dirname(filePath), pt.basenameWithoutExtension(filePath))
              .replaceAll(pt.separator, '_')
              .camelCase: filePath,
      },
    );
    return [root];
  }
}
