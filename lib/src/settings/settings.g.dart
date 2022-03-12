// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YamlSettings _$YamlSettingsFromJson(Map json) => $checkedCreate(
      'YamlSettings',
      json,
      ($checkedConvert) {
        final val = YamlSettings(
          mekAssets:
              $checkedConvert('mek_assets', (v) => Settings.fromJson(v as Map)),
        );
        return val;
      },
      fieldKeyMap: const {'mekAssets': 'mek_assets'},
    );

Settings _$SettingsFromJson(Map json) => $checkedCreate(
      'Settings',
      json,
      ($checkedConvert) {
        final val = Settings(
          pageWidth: $checkedConvert('page_width', (v) => v as int? ?? 80),
          format: $checkedConvert(
              'format', (v) => $enumDecode(_$BuildFormatEnumMap, v)),
          package: $checkedConvert('package', (v) => v as String?),
          groups: $checkedConvert(
              'groups',
              (v) => (v as List<dynamic>)
                  .map((e) => GroupSettings.fromJson(e as Map))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'pageWidth': 'page_width'},
    );

const _$BuildFormatEnumMap = {
  BuildFormat.single: 'single',
  BuildFormat.multi: 'multi',
};

GroupSettings _$GroupSettingsFromJson(Map json) => $checkedCreate(
      'GroupSettings',
      json,
      ($checkedConvert) {
        final val = GroupSettings(
          inputDir: $checkedConvert('input_dir', (v) => v as String),
          className: $checkedConvert('class_name', (v) => v as String? ?? 'R'),
          include: $checkedConvert(
              'include',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const ['**']),
          outputDir:
              $checkedConvert('output_dir', (v) => v as String? ?? 'lib'),
        );
        return val;
      },
      fieldKeyMap: const {
        'inputDir': 'input_dir',
        'className': 'class_name',
        'outputDir': 'output_dir'
      },
    );
