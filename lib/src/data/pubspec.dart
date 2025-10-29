import 'package:json_annotation/json_annotation.dart';
import 'package:mek_assets/src/data/mek_assets_config.dart';
import 'package:pub_semver/pub_semver.dart';

part 'pubspec.g.dart';

@JsonSerializable()
class Pubspec {
  final PubspecEnvironment environment;
  final Flutter flutter;
  final MekAssetsConfig? mekAssets;

  const Pubspec({required this.environment, required this.flutter, this.mekAssets});

  factory Pubspec.fromJson(Map<dynamic, dynamic> map) => _$PubspecFromJson(map);
}

@JsonSerializable()
class PubspecEnvironment {
  @JsonKey(fromJson: _parseVersion)
  final VersionRange? sdk;

  const PubspecEnvironment({required this.sdk});

  factory PubspecEnvironment.fromJson(Map<dynamic, dynamic> map) =>
      _$PubspecEnvironmentFromJson(map);

  static VersionRange? _parseVersion(String source) {
    final version = VersionConstraint.parse(source);
    if (version == VersionConstraint.any || version == VersionConstraint.empty) return null;
    return version as VersionRange;
  }
}

@JsonSerializable()
class Flutter {
  final List<FlutterAsset> assets;

  const Flutter({this.assets = const <FlutterAsset>[]});

  factory Flutter.fromJson(Map<dynamic, dynamic> map) => _$FlutterFromJson(map);

  @override
  String toString() => '  assets:\n${assets.map((e) => '    - $e').join('\n')}';
}

@JsonSerializable()
class FlutterAsset {
  final String path;

  const FlutterAsset({required this.path});

  factory FlutterAsset.fromJson(Object? data) {
    if (data is String) return FlutterAsset(path: data);
    return _$FlutterAssetFromJson(data! as Map<dynamic, dynamic>);
  }

  @override
  String toString() => 'path: $path';
}
