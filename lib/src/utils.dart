import 'dart:async';
import 'dart:io' as io;

import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as pt;

var lg = Logger.standard(ansi: Ansi(io.stdout.supportsAnsiEscapes));

extension LoggerExtension on Logger {
  void e(String message) => stderr(message);

  void v(String message) => trace(message);

  void w(String message) => stdout('${ansi.yellow}$message${ansi.none}');

  void i(String message) => stdout('${ansi.green}$message${ansi.none}');
}

class Utils {
  static String encodePosixPath(String rootPath, String path) {
    final posixPath = pt.posix.joinAll(pt.split(path));
    return pt.posix.join(rootPath, posixPath);
  }

  static String encodeAssetPath(String? package, String rootPath, String path) {
    final posixPath = encodePosixPath(rootPath, path);
    return package == null ? posixPath : 'packages/$package/$posixPath';
  }

  static String? writeInTags(String content, String tag, String Function() innerContent) {
    final startWildcardRegExp =
        RegExp(r'([ ]{4}# tag GENERATED CODE - DO NOT MODIFY BY HAND\n)'.replaceFirst('tag', tag));
    final endWildcardRegExp = RegExp(r'([ ]{4}# tag(\n|$))'.replaceFirst('tag', tag));

    final startWildcardMatches = startWildcardRegExp.allMatches(content).toList();
    final endWildcardMatches = endWildcardRegExp.allMatches(content).toList();

    if (startWildcardMatches.length > 1 || endWildcardMatches.length > 1) {
      throw InvalidTagsException(
        startWildcardCount: startWildcardMatches.length,
        endWildcardCount: endWildcardMatches.length,
      );
    }

    final start = startWildcardMatches[0].end;
    final end = endWildcardMatches[0].start;
    final previous = content.substring(0, start);
    final next = content.substring(end);

    return '$previous${innerContent()}$next';
  }

  static Stream<T> merge<T>(Iterable<Stream<T>> streams) {
    return Stream.multi((controller) {
      var total = 0;
      var count = 0;

      void onDone() {
        count += 1;
        if (count < total) return;
        controller.close();
      }

      for (final stream in streams) {
        total += 1;
        stream.listen(
          controller.addSync,
          onError: controller.addErrorSync,
          onDone: onDone,
        );
      }
    });
  }
}

class InvalidTagsException {
  final int startWildcardCount;
  final int endWildcardCount;

  const InvalidTagsException({
    required this.startWildcardCount,
    required this.endWildcardCount,
  });

  String get formattedMessage {
    final buffer = StringBuffer('Invalid pubspec tags\n');

    void write(String name, int count) {
      if (count == 0) {
        buffer.writeln('Not has $name wildcard');
      } else if (count > 1) {
        buffer.writeln('Has many $name wildcards');
      }
    }

    write('start', startWildcardCount);
    write('end', endWildcardCount);

    return buffer.toString();
  }
}

extension MapX<K, V> on Map<K, V> {
  Iterable<R> mapEntries<R>(R Function(K key, V value) mapper) sync* {
    for (final entry in entries) {
      yield mapper(entry.key, entry.value);
    }
  }
}
