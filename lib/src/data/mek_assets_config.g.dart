// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_cast

part of 'mek_assets_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MekAssetsConfig _$MekAssetsConfigFromJson(Map json) => $checkedCreate(
  'MekAssetsConfig',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const ['output_directory', 'output_file', 'single_assets_class', 'assets'],
    );
    final val = MekAssetsConfig(
      outputDirectory: $checkedConvert('output_directory', (v) => v as String? ?? 'lib'),
      outputFile: $checkedConvert('output_file', (v) => v as String? ?? 'assets.g.dart'),
      singleAssetsClass: $checkedConvert(
        'single_assets_class',
        (v) => v == null ? 'Assets' : MekAssetsConfig._fallbackClassFromJson(v as Object),
      ),
      assets: $checkedConvert(
        'assets',
        (v) =>
            (v as Map?)?.map((k, e) => MapEntry(k as String, MekAssetConfig.fromJson(e))) ??
            const {},
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'outputDirectory': 'output_directory',
    'outputFile': 'output_file',
    'singleAssetsClass': 'single_assets_class',
  },
);
