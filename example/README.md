# Examples

This directory contains examples of how to use the `mek_assets` package.

## Default

The `default` example shows the default behavior of the package when run as a script. It generates classes for each asset directory and a main class for single assets.

- [`pubspec.yaml`](https://github.com/BreX900/mek_assets/tree/master/example/default/pubspec.yaml): The `pubspec.yaml` file with the assets configuration.
- [`lib/assets.dart`](https://github.com/BreX900/mek_assets/tree/master/example/default/lib/assets.dart): The generated class for single assets.
- [`lib/images.dart`](https://github.com/BreX900/mek_assets/tree/master/example/default/lib/images.dart): The generated class for the `assets/images/` directory.

## Custom

The `custom` example shows how to customize the code generation by adding a `mek_assets` section to your `pubspec.yaml` file.

- [`pubspec.yaml`](https://github.com/BreX900/mek_assets/tree/master/example/custom/pubspec.yaml): The `pubspec.yaml` file with the assets and `mek_assets` configuration.
- [`lib/assets/r.g.dart`](https://github.com/BreX900/mek_assets/tree/master/example/custom/lib/assets/r.g.dart): The generated file with the custom configuration.

## Build Runner

The `build_runner` example shows how to use the package with `build_runner`.

- [`pubspec.yaml`](https://github.com/BreX900/mek_assets/tree/master/example/build_runner/pubspec.yaml): The `pubspec.yaml` file with the `build_runner` and `mek_assets` dependencies.
- [`build.yaml`](https://github.com/BreX900/mek_assets/tree/master/example/build_runner/build.yaml): The `build.yaml` file with the `mek_assets` configuration.
- [`lib/assets.dart`](https://github.com/BreX900/mek_assets/tree/master/example/build_runner/lib/assets.dart): The generated file.
