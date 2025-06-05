import 'package:json_annotation/json_annotation.dart';

part 'dto.g.dart';

@JsonSerializable()
class PubspecDto {
  final FlutterDto flutter;
  final MekAssetsDto mekAssets;

  const PubspecDto({required this.flutter, this.mekAssets = const MekAssetsDto()});

  factory PubspecDto.fromJson(Map<dynamic, dynamic> map) => _$PubspecDtoFromJson(map);

  @override
  String toString() => 'flutter:\n$flutter\nmek_assets:\n$mekAssets';
}

@JsonSerializable()
class FlutterDto {
  final List<AssetDto> assets;

  const FlutterDto({this.assets = const <AssetDto>[]});

  factory FlutterDto.fromJson(Map<dynamic, dynamic> map) => _$FlutterDtoFromJson(map);

  @override
  String toString() => '  assets:\n${assets.map((e) => '    - $e').join('\n')}';
}

@JsonSerializable()
class AssetDto {
  final String path;

  const AssetDto({required this.path});

  factory AssetDto.fromJson(Object? data) {
    if (data is String) return AssetDto(path: data);
    return _$AssetDtoFromJson(data! as Map<dynamic, dynamic>);
  }

  @override
  String toString() => 'path: $path';
}

@JsonSerializable(disallowUnrecognizedKeys: true)
class MekAssetsDto {
  final String outputDirectory;
  @JsonKey(fromJson: _fallbackClassFromJson)
  final String? outputFilesClass;
  final Map<String, MekAssetDto> assets;

  const MekAssetsDto({
    this.outputDirectory = 'lib',
    this.outputFilesClass = 'Assets',
    this.assets = const {},
  });

  factory MekAssetsDto.fromJson(Map<dynamic, dynamic> map) => _$MekAssetsDtoFromJson(map);

  static String? _fallbackClassFromJson(Object source) => source is bool ? null : source as String;

  @override
  String toString() => '  output_directory: $outputDirectory\n'
      '  output_files_class: $outputFilesClass\n'
      '  assets:\n'
      '${assets.entries.map((e) => '    ${e.key}:\n${e.value}').join('\n')}';
}

class MekAssetDto {
  final bool generate;
  final String? outputClass;

  const MekAssetDto({this.generate = true, this.outputClass});

  factory MekAssetDto.fromJson(Object? source) {
    if (source == null) return const MekAssetDto();
    if (source is bool) return MekAssetDto(generate: source);
    return MekAssetDto(outputClass: source as String);
  }

  @override
  String toString() => '      generate: $generate\n'
      '      output_class: $outputClass';
}

@JsonSerializable()
class AnalysisOptionsDto {
  final FormatterDto formatter;

  const AnalysisOptionsDto({this.formatter = const FormatterDto()});

  factory AnalysisOptionsDto.fromJson(Map<dynamic, dynamic> map) =>
      _$AnalysisOptionsDtoFromJson(map);
}

@JsonSerializable()
class FormatterDto {
  final int pageWidth;

  const FormatterDto({this.pageWidth = 80});

  factory FormatterDto.fromJson(Map<dynamic, dynamic> map) => _$FormatterDtoFromJson(map);
}
