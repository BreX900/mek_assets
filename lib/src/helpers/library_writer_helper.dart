import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:mek_assets/src/data/analysis_options.dart';
import 'package:mek_assets/src/decode_yaml_file.dart';
import 'package:mek_assets/src/helpers/helper_core.dart';

mixin LibraryWriterHelper on HelperCore {
  Future<void> writeLibrary(Library library) async {
    final analysisOptions = await fileSystem.readAsYaml(
      'analysis_options.yaml',
      AnalysisOptions.fromJson,
      orElse: () => const AnalysisOptions(),
    );

    final emitter = DartEmitter(useNullSafetySyntax: true);
    final formatter = DartFormatter(
      languageVersion: pubspec.environment.sdk?.min ?? DartFormatter.latestLanguageVersion,
      pageWidth: analysisOptions.formatter.pageWidth,
    );

    final content = formatter.format('${library.accept(emitter)}');

    await fileSystem.writeAsString(config.outputFile, content);
  }
}
