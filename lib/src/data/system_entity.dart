sealed class SystemEntity {
  final String path;

  const SystemEntity({required this.path});
}

class DirectoryEntity extends SystemEntity {
  final List<String> children;

  const DirectoryEntity({required super.path, required this.children});

  @override
  String toString() => '$path($children)';
}

class FileEntity extends SystemEntity {
  const FileEntity({required super.path});

  @override
  String toString() => path;
}
