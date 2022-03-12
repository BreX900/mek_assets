class Options {
  final int pageWidth;
  final String className;
  final List<GroupOptions> groups;

  const Options({
    this.pageWidth = 80,
    this.className = 'R',
    required this.groups,
  });
}

class GroupOptions {
  final List<String> paths;
  final String? className;
  final List<String> types;
  final String outputDir;

  const GroupOptions({
    required this.paths,
    this.className,
    this.types = const [],
    required this.outputDir,
  });

  String resolveClassName(Options options) => className ?? options.className;
}
