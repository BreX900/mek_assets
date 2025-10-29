import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as path_lib;
import 'package:recase/recase.dart';

part 'mek_assets_config.g.dart';
@JsonSerializable(disallowUnrecognizedKeys: true)
class MekAssetsConfig {
  final String outputDirectory;
  @JsonKey(fromJson: _fallbackClassFromJson)
  final String? outputFilesClass;
  final Map<String, MekAssetConfig> assets;

  const MekAssetsConfig({
    this.outputDirectory = 'lib',
    this.outputFilesClass = 'Assets',
    this.assets = const {},
  });

  String get outputFile => path_lib.join(outputDirectory, 'assets.g.dart');

  factory MekAssetsConfig.fromJson(Map<dynamic, dynamic> map) => _$MekAssetsConfigFromJson(map);

  static String? _fallbackClassFromJson(Object source) => source is bool ? null : source as String;
}

class MekAssetConfig {
  final bool generate;
  final String? outputClass;

  String? get libraryName => outputClass?.snakeCase;

  const MekAssetConfig({this.generate = true, this.outputClass});

  factory MekAssetConfig.fromJson(Object? source) {
    if (source == null) return const MekAssetConfig();
    if (source is bool) return MekAssetConfig(generate: source);
    return MekAssetConfig(outputClass: source as String);
  }
}
