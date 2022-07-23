import 'dart:io';

import 'package:path/path.dart';

void main() async {
  final folders = [
    'single',
    'multi',
    'tree',
  ];

  final results = await Future.wait(folders.map((folder) async {
    // final res = Process.runSync('ls', []);
    // print(res.stdout);
    final result = await Process.run(
      'dart',
      ['pub', 'global', 'run', 'mek_assets', 'build'],
      workingDirectory: join('example', folder),
    );
    return 'Format: $folder\n${result.stdout}\n${result.stderr}';
  }));

  print(results.join('\n'));
}
