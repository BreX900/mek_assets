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
  BuildFormat.tree: 'tree',
};

GroupSettings _$GroupSettingsFromJson(Map json) => $checkedCreate(
      'GroupSettings',
      json,
      ($checkedConvert) {
        final val = GroupSettings(
          inputDir: $checkedConvert('input_dir', (v) => v as String),
          prefixClassName:
              $checkedConvert('prefix_class_name', (v) => v as String?),
          className: $checkedConvert('class_name', (v) => v as String?),
          include: $checkedConvert(
              'include',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const ['**']),
          exclude: $checkedConvert(
              'exclude',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          createMapFiles:
              $checkedConvert('create_map_files', (v) => v as bool? ?? false),
          outputDir:
              $checkedConvert('output_dir', (v) => v as String? ?? 'lib'),
          outputFileName:
              $checkedConvert('output_file_name', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'inputDir': 'input_dir',
        'prefixClassName': 'prefix_class_name',
        'className': 'class_name',
        'createMapFiles': 'create_map_files',
        'outputDir': 'output_dir',
        'outputFileName': 'output_file_name'
      },
    );
