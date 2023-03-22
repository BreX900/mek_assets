import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as pt;
import 'package:recase/recase.dart';

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
enum BuildFormat { single, multi, tree }

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
  final String? prefixClassName;
  final String? className;
  final String outputDir;
  final String? outputFileName;

  const GroupSettings._({
    required this.inputDir,
    this.prefixClassName,
    this.className,
    this.include = const ['**'],
    this.outputDir = 'lib',
    this.outputFileName,
  });

  factory GroupSettings({
    required String inputDir,
    String? prefixClassName,
    String? className,
    List<String> include = const ['**'],
    String outputDir = 'lib',
    String? outputFileName,
  }) {
    return GroupSettings._(
      inputDir: pt.posix.normalize(inputDir),
      prefixClassName: prefixClassName,
      className: className,
      include: include.isEmpty ? const ['**'] : include,
      outputDir: outputDir,
      outputFileName: outputFileName,
    );
  }

  String resolveClassName(Settings settings, [String dir = '.']) {
    final dirName = pt.basename(dir);
    final partialName =
        dirName == '.' ? (className ?? pt.basename(inputDir).pascalCase) : dirName.pascalCase;
    return prefixClassName != null ? '$prefixClassName$partialName' : partialName;
  }

  String resolveOutputFile(Settings settings) {
    return pt.join(outputDir, '${outputFileName ?? resolveClassName(settings).snakeCase}.dart');
  }

  factory GroupSettings.fromJson(Map<dynamic, dynamic> map) => _$GroupSettingsFromJson(map);
}

extension BuildFormatExtensions on BuildFormat {
  R fold<R>({
    required R Function() single,
    required R Function() multi,
    required R Function() tree,
  }) {
    switch (this) {
      case BuildFormat.single:
        return single();
      case BuildFormat.multi:
        return multi();
      case BuildFormat.tree:
        return tree();
    }
  }
}
