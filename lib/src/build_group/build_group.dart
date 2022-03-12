import 'package:code_builder/code_builder.dart';
import 'package:file/file.dart';
import 'package:mek_generate_assets/src/options.dart';
import 'package:path/path.dart';

abstract class BuildGroup {
  final Options options;
  final FileSystem fileSystem;
  final Context pt = posix;

  BuildGroup({
    required this.options,
    required this.fileSystem,
  });

  List<Class> call(GroupOptions groupOptions, Iterable<String> filePaths);
}
