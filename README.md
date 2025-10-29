# Mek Assets
Automatically generate dart classes from pubspec.yaml `assets` field entries.

## Usage

This package can be used as a script or with `build_runner`.

### Script

1.  Activate: `dart pub global activate mek_assets`
2.  Generate files with: `dart pub global run mek_assets`

See [script example](https://github.com/BreX900/mek_assets/tree/master/example/default/pubspec.yaml)

### Build Runner

1.  Add `build_runner` and `mek_assets` to your `pubspec.yaml` `dev_dependencies`:
    ```yaml
    dev_dependencies:
      build_runner:
      mek_assets:
    ```
2.  Generate files with: `dart run build_runner build`

See [build_runner example](https://github.com/BreX900/mek_assets/tree/master/example/build_runner/pubspec.yaml) and the [build.yaml](https://github.com/BreX900/mek_assets/tree/master/example/build_runner/build.yaml) configuration.

## Advance Package Usage

In your `build.yaml` or `pubspec.yaml` file, you can configure the generator.

```yaml
mek_assets:
  # Directory where to save the generated files
  output_directory: lib
  # File name where to generate assets classes
  output_file: assets.g.dart
  # Name of the main class that contains the single assets. Defaults is "Assets" name.
  # You can pass `false` to not create a class that contains the individual files.
  single_assets_class: Assets

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
