# Mek Assets
Automatically generate dart classes from pubspec.yaml `assets` field entries.

## Usage

1. Activate: `dart/flutter pub global activate mek_assets`

2. You can generate libraries files with: `<dart|flutter> pub global run mek_assets`

### Example

See [minimal example](https://github.com/BreX900/mek_assets/tree/master/example/default/pubspec.yaml)

The [pubspec.yaml](https://github.com/BreX900/mek_assets/tree/master/example/default/pubspec.yaml) file
```yaml
name: example
description: Automatically generate dart classes / flutter pubspec entries for your assets files.
version: 0.0.1
environment:
  sdk: '>=3.5.0 <4.0.0'

flutter:
  assets:
    - assets/images/
    - assets/main_image.jpg
    - assets/response.json
```

Run `mek_assets` to generate the `Assets` and `Images` class

[lib/assets.dart](https://github.com/BreX900/mek_assets/tree/master/example/default/lib/assets.dart)
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

abstract final class Assets {
  static const String assetsMainImage = 'assets/main_image.jpg';

  static const String assetsResponse = 'assets/response.json';
}

```

[lib/images.dart](https://github.com/BreX900/mek_assets/tree/master/example/default/lib/images.dart)
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

abstract final class Images {
  static const String shieldHero = 'assets/images/shield_hero.jpg';
}

```

## Advance Package Usage

```yaml
mek_assets:
  # Directory where to save the generated files. Defaults `lib`
  output_directory: lib/assets
  # Name of the main class that contains the single assets. Defaults is "Assets" name.
  # You can pass `false` to not create a class that contains the individual files.
  output_files_class: Assets

  assets:
    # Name of the class that contains the assets. Defaults is directory name.
    <ASSET_PATH>: Images
    # You can disable generation with `false` value
    <ASSET_PATH_IGNORED>: false
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/BreX900/mek_assets/issues).

# Extra

- [index_generator](https://pub.dev/packages/index_generator): Automatically generate index / barrel files with all the exports needed for your library.
- [mek_data_class](https://pub.dev/packages/mek_data_class): Generate `hashCode`, `==`, `toString`, `copyWith` and `change` methods with low code.
