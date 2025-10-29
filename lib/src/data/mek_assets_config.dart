import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as path_lib;

part 'mek_assets_config.g.dart';

@JsonSerializable(disallowUnrecognizedKeys: true)
class MekAssetsConfig {
  final String outputDirectory;
  final String outputFile;
  @JsonKey(fromJson: _fallbackClassFromJson)
  final String? singleAssetsClass;
  final Map<String, MekAssetConfig> assets;

  const MekAssetsConfig({
    this.outputDirectory = 'lib',
    this.outputFile = 'assets.g.dart',
    this.singleAssetsClass = 'Assets',
    this.assets = const {},
  });

  String get outputPath => path_lib.join(outputDirectory, outputFile);

  factory MekAssetsConfig.fromJson(Map<dynamic, dynamic> map) => _$MekAssetsConfigFromJson(map);

  static String? _fallbackClassFromJson(Object source) => source is bool ? null : source as String;
}

class MekAssetConfig {
  final bool generate;
  @JsonKey(name: 'class')
  final String? class$;

  const MekAssetConfig({this.generate = true, this.class$});

  factory MekAssetConfig.fromJson(Object? source) {
    if (source == null) return const MekAssetConfig();
    if (source is bool) return MekAssetConfig(generate: source);
    return MekAssetConfig(class$: source as String);
  }
}
