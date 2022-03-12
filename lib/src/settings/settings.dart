import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as pt;

part 'settings.g.dart';

@JsonSerializable()
class YamlSettings {
  final Settings mekAssets;

  const YamlSettings({
    required this.mekAssets,
  });

  factory YamlSettings.fromJson(Map<dynamic, dynamic> map) => _$YamlSettingsFromJson(map);
}

@JsonEnum()
enum BuildFormat { single, multi }

@JsonSerializable()
class Settings {
  final int pageWidth;
  final String? package;
  final BuildFormat format;
  final List<GroupSettings> groups;

  const Settings({
    this.pageWidth = 80,
    required this.format,
    this.package,
    required this.groups,
  });

  factory Settings.fromJson(Map<dynamic, dynamic> map) => _$SettingsFromJson(map);
}

@JsonSerializable()
class GroupSettings {
  final String inputDir;
  final List<String> include;
  final String className;
  final String outputDir;

  const GroupSettings._({
    required this.inputDir,
    this.className = 'R',
    this.include = const ['**'],
    this.outputDir = 'lib',
  });

  factory GroupSettings({
    required String inputDir,
    String className = 'R',
    List<String> include = const ['**'],
    String outputDir = 'lib',
  }) {
    return GroupSettings._(
      inputDir: pt.posix.normalize(inputDir),
      className: className,
      include: include.isEmpty ? const ['**'] : include,
      outputDir: outputDir,
    );
  }

  String resolveClassName(Settings settings) => className;
  String resolveOutputDir(Settings settings) => outputDir;

  factory GroupSettings.fromJson(Map<dynamic, dynamic> map) => _$GroupSettingsFromJson(map);
}

extension BuildFormatExtensions on BuildFormat {
  R fold<R>({
    required R Function() single,
    required R Function() multi,
  }) {
    switch (this) {
      case BuildFormat.single:
        return single();
      case BuildFormat.multi:
        return multi();
    }
  }
}
