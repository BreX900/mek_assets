import 'package:file/file.dart';
import 'package:mek_assets/src/build_group/build_group_node.dart';
import 'package:mek_assets/src/settings/settings.dart';

class BuildSingleGroupNode extends BuildGroupNode {
  BuildSingleGroupNode({
    required Settings options,
    required FileSystem fileSystem,
  }) : super(settings: options, fileSystem: fileSystem);

  @override
  Node call(GroupSettings groupSettings, Iterable<String> filePaths) {
    return Node(
      dirName: groupSettings.className,
      filePaths: filePaths.toList(),
    );
  }
}
