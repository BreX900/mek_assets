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
      allowedKeys: const ['output_directory', 'output_files_class', 'assets'],
    );
    final val = MekAssetsConfig(
      outputDirectory: $checkedConvert(
        'output_directory',
        (v) => v as String? ?? 'lib',
      ),
      outputFilesClass: $checkedConvert(
        'output_files_class',
        (v) => v == null
            ? 'Assets'
            : MekAssetsConfig._fallbackClassFromJson(v as Object),
      ),
      assets: $checkedConvert(
        'assets',
        (v) =>
            (v as Map?)?.map(
              (k, e) => MapEntry(k as String, MekAssetConfig.fromJson(e)),
            ) ??
            const {},
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'outputDirectory': 'output_directory',
    'outputFilesClass': 'output_files_class',
  },
);
