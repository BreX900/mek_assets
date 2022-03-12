import 'package:path/path.dart' as pt;

class Utils {
  static String encodeAssetPath(String platformPath) {
    final platformSegments = pt.split(platformPath).skip(1);

    return pt.posix.joinAll(platformSegments);

    // final posixPath = platformPath.replaceAll(pt.current, '/');
  }
}
