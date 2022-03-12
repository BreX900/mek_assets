// ignore: implementation_imports
import 'package:mime/src/default_extension_map.dart';

final mimeMap = defaultExtensionMap;

class Mime {
  final String pattern;

  Mime(this.pattern);

  bool match(String extension, String type) {
    final extensions = <String>[];

    final isValidMime = RegExp(r'^(\w+\/\*?([^/*])+)$');

    if (type.contains('/')) {
      if (!isValidMime.hasMatch(type)) throw 'Not valid match';
      final segments = type.split('/');
      final mime = segments[0];
      final wildcard = segments[1];
      if (wildcard == '*') {
        extensions.addAll(mimeMap.entries.where((e) => e.value.startsWith(mime)).map((e) => e.key));
      } else {
        extensions.addAll(mimeMap.entries.where((e) => e.value == type).map((e) => e.key));
      }
      return extensions.contains(extension);
    }

    return extension == type;
  }
}
