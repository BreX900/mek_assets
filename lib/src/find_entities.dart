import 'dart:io';

import 'package:mek_assets/src/data/dto.dart';
import 'package:mek_assets/src/data/entity.dart';
import 'package:path/path.dart';

Future<List<SystemEntity>> findEntities(List<AssetDto> assets) async {
  return await assets.map((asset) async {
    if (asset.path.endsWith('/')) {
      final directory = Directory(asset.path);

      final files = await directory.list().toList();

      return DirectoryEntity(
        path: directory.path,
        children: files
            .whereType<File>()
            .map((file) => file.path)
            .where((path) => !basename(path).startsWith('.'))
            .toList(),
      );
    } else {
      return FileEntity(path: asset.path);
    }
  }).wait;
}
