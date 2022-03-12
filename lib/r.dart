class R {
  const R._();

  static const Assets assets = Assets._();
}

class Assets {
  const Assets._();

  final Sub sub = const Sub._();

  final String test = 'assets/test.json';
}

class Sub {
  const Sub._();

  final Sub2 sub2 = const Sub2._();
}

class Sub2 {
  const Sub2._();

  final String pinco = 'assets/sub/sub2/pinco.json';
}
