import 'package:checked_yaml/checked_yaml.dart';
import 'package:mek_assets/src/helpers/helper_core.dart';

T decodeYaml<T>(String contents, T Function(Map map) from, {Uri? sourceUrl}) {
  try {
    return checkedYamlDecode(contents, (map) => from(map!), sourceUrl: sourceUrl);
  } on ParsedYamlException catch (error) {
    throw StateException(error.formattedMessage!);
  }
}

extension ReadAsYamlFileSystemExtension on FileSystem {
  Future<T> readAsYaml<T>(String path, T Function(Map map) from, {T Function()? orElse}) async {
    if (!await canRead(path)) {
      if (orElse != null) return orElse();
      throw StateException('The $path not exists.');
    }

    final content = await readAsString(path);
    return decodeYaml(content, from, sourceUrl: Uri.file(path));
  }
}
