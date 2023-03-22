import 'package:collection/collection.dart';
import 'package:file/file.dart';
import 'package:mek_assets/src/build_group/build_group_node.dart';
import 'package:mek_assets/src/settings/settings.dart';
import 'package:mek_assets/src/utils.dart';
import 'package:path/path.dart' as pt;
import 'package:recase/recase.dart';

class BuildMultiGroupNode extends BuildGroupNode {
  BuildMultiGroupNode({
    required Settings options,
    required FileSystem fileSystem,
  }) : super(settings: options, fileSystem: fileSystem);

  @override
  List<Node> call(GroupSettings groupSettings, Iterable<String> filePaths) {
    final nodes = filePaths.groupListsBy((element) => pt.dirname(element));

    return nodes.mapEntries((dirName, filePaths) {
      return Node(
        dirName: dirName,
        files: {
          for (final filePath in filePaths)
            pt.basenameWithoutExtension(filePath).camelCase: filePath,
        },
      );
    }).toList();
  }
}
