import 'package:mek_assets/src/data/system_entity.dart';
import 'package:mek_assets/src/helpers/helper_core.dart';
import 'package:path/path.dart';

mixin EntitiesFinderHelper on HelperCore {
  Future<List<SystemEntity>> findEntities() async {
    return await pubspec.flutter.assets.map((asset) async {
      if (asset.path.endsWith('/')) {
        final assets = await fileSystem.findAssets(asset.path);

        return DirectoryEntity(
          path: asset.path,
          children: assets.where((path) => !basename(path).startsWith('.')).toList(),
        );
      } else {
        return FileEntity(path: asset.path);
      }
    }).wait;
  }
}
