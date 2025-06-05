// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_cast

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PubspecDto _$PubspecDtoFromJson(Map json) => $checkedCreate(
      'PubspecDto',
      json,
      ($checkedConvert) {
        final val = PubspecDto(
          flutter:
              $checkedConvert('flutter', (v) => FlutterDto.fromJson(v as Map)),
          mekAssets: $checkedConvert(
              'mek_assets',
              (v) => v == null
                  ? const MekAssetsDto()
                  : MekAssetsDto.fromJson(v as Map)),
        );
        return val;
      },
      fieldKeyMap: const {'mekAssets': 'mek_assets'},
    );

FlutterDto _$FlutterDtoFromJson(Map json) => $checkedCreate(
      'FlutterDto',
      json,
      ($checkedConvert) {
        final val = FlutterDto(
          assets: $checkedConvert(
              'assets',
              (v) =>
                  (v as List<dynamic>?)?.map(AssetDto.fromJson).toList() ??
                  const <AssetDto>[]),
        );
        return val;
      },
    );

AssetDto _$AssetDtoFromJson(Map json) => $checkedCreate(
      'AssetDto',
      json,
      ($checkedConvert) {
        final val = AssetDto(
          path: $checkedConvert('path', (v) => v as String),
        );
        return val;
      },
    );

MekAssetsDto _$MekAssetsDtoFromJson(Map json) => $checkedCreate(
      'MekAssetsDto',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'output_directory',
            'output_files_class',
            'assets'
          ],
        );
        final val = MekAssetsDto(
          outputDirectory:
              $checkedConvert('output_directory', (v) => v as String? ?? 'lib'),
          outputFilesClass: $checkedConvert(
              'output_files_class',
              (v) => v == null
                  ? 'Assets'
                  : MekAssetsDto._fallbackClassFromJson(v as Object)),
          assets: $checkedConvert(
              'assets',
              (v) =>
                  (v as Map?)?.map(
                    (k, e) => MapEntry(k as String, MekAssetDto.fromJson(e)),
                  ) ??
                  const {}),
        );
        return val;
      },
      fieldKeyMap: const {
        'outputDirectory': 'output_directory',
        'outputFilesClass': 'output_files_class'
      },
    );

AnalysisOptionsDto _$AnalysisOptionsDtoFromJson(Map json) => $checkedCreate(
      'AnalysisOptionsDto',
      json,
      ($checkedConvert) {
        final val = AnalysisOptionsDto(
          formatter: $checkedConvert(
              'formatter',
              (v) => v == null
                  ? const FormatterDto()
                  : FormatterDto.fromJson(v as Map)),
        );
        return val;
      },
    );

FormatterDto _$FormatterDtoFromJson(Map json) => $checkedCreate(
      'FormatterDto',
      json,
      ($checkedConvert) {
        final val = FormatterDto(
          pageWidth:
              $checkedConvert('page_width', (v) => (v as num?)?.toInt() ?? 80),
        );
        return val;
      },
      fieldKeyMap: const {'pageWidth': 'page_width'},
    );
