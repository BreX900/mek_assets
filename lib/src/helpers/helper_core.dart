import 'package:mek_assets/src/data/mek_assets_config.dart';
import 'package:mek_assets/src/data/pubspec.dart';

abstract class HelperCore {
  final FileSystem fileSystem;
  final Pubspec pubspec;
  final MekAssetsConfig config;

  const HelperCore({required this.fileSystem, required this.pubspec, required this.config});
}

abstract class FileSystem {
  Future<bool> canRead(String path);

  Future<List<String>> findAssets(String path);

  Future<String> readAsString(String path);

  Future<void> writeAsString(String path, String contents);
}

class StateException implements Exception {
  final String message;

  StateException(this.message);

  @override
  String toString() => message;
}
