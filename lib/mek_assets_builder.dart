import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:mek_assets/src/assets_generator.dart';
import 'package:mek_assets/src/data/mek_assets_config.dart';
import 'package:mek_assets/src/data/pubspec.dart';
import 'package:mek_assets/src/decode_yaml_file.dart';
import 'package:mek_assets/src/helpers/helper_core.dart';

// https://github.com/dart-lang/build/blob/build_runner-v2.6.0/docs/writing_a_builder.md
Builder mekAssetsBuilder(BuilderOptions options) {
  final config = MekAssetsConfig.fromJson(options.config);

  return _AssetsBuilder(config);
}

class _AssetsBuilder implements Builder {
  final MekAssetsConfig config;

  _AssetsBuilder(this.config);

  @override
  Map<String, List<String>> get buildExtensions => {
    'pubspec.yaml': [config.outputFile],
  };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final fileSystem = _BuildFileSystem(buildStep);

    final pubspec = await fileSystem.readAsYaml('pubspec.yaml', Pubspec.fromJson);
    if (pubspec.mekAssets != null) {
      throw StateException(
        'If you are using `build_runner` package remove the "mek_assets" configuration from '
        'the `pubspec.yaml` file and move it to the `build.yaml` file:\n'
        'targets:\n'
        '  \$default:\n'
        '    builders:\n'
        '      mek_assets:\n'
        '        options:\n'
        '          # Write here the "mek_assets" configuration',
      );
    }

    final generator = AssetsGenerator(fileSystem: fileSystem, pubspec: pubspec, config: config);
    await generator.generate();
  }
}

class _BuildFileSystem extends FileSystem {
  final BuildStep buildStep;

  _BuildFileSystem(this.buildStep);

  @override
  Future<List<String>> findAssets(String path) async {
    final assets = await buildStep.findAssets(Glob('$path*')).toList();
    return assets.map((e) => e.path).toList();
  }

  @override
  Future<bool> canRead(String path) async {
    final assetId = AssetId(buildStep.inputId.package, path);
    return await buildStep.canRead(assetId);
  }

  @override
  Future<String> readAsString(String path) async {
    final assetId = AssetId(buildStep.inputId.package, path);
    return await buildStep.readAsString(assetId);
  }

  @override
  Future<void> writeAsString(String path, String contents) async {
    final assetId = AssetId(buildStep.inputId.package, path);
    await buildStep.writeAsString(assetId, contents);
  }
}
