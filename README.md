# Mek Assets
Automatically generate dart classes / flutter pubspec entries for your assets files.

## Usage

1. Activate: `dart/flutter pub global activate mek_assets`

2. Create `mek_assets.yaml` file or add in your `pubspec.yaml` file:
```yaml
mek_assets:
  # It supports generating assets in a `single` class, into `multi` classes based on directory or `tree` classes structure based on directory
  format: multi # single, multi, tree
  # The various assets groups
  groups:
    # Path of assets
    - input_dir: assets
      prefix_class_name: R
      output_file_name: r
```

3. *Optional*: Add these comments to `pubspec.yaml` to automatically generate all the entries needed to flutter 
````yaml
flutter:
  assets:
    - ...
    # mek_assets GENERATED CODE - DO NOT MODIFY BY HAND
    - The auto generated code will be added here, copy paste this section
    # mek_assets
````

4. You can generate index files with: `<dart|flutter> pub global run mek_assets build`

## Advance and Package Usage

```yaml
index_generator:
  # The page width uses when the dart code is generated
  page_width: 80
  # Add the package name to the paths of the assets
  package: awesome_assets

  groups:
    - input_dir: assets
      # You can define specific filters for this assets group
      include:
        # You can define specific export assets files
        - '**.png'
      # Prefix of the classes that contains the assets. Defaults nothing.
      prefix_class_name: R
      # Name of the main class that contains the assets. Defaults input directory name.
      class_name: AwesomeAssets
      # Directory where to save the generated files. Defaults `lib`
      output_dir: lib/src
      # Generated file name. Defaults input directory name 
      output_file_name: 'r'
```

## Recommended format settings

### Single / Tree
```yaml
      class_name: R
      output_file_name: r
```

### Multi
```yaml
      prefix_class_name: R
      output_file_name: r
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/BreX900/mek_assets/issues).

# Extra

- [index_generator](https://pub.dev/packages/index_generator): Automatically generate index / barrel files with all the exports needed for your library.
- [mek_data_class](https://pub.dev/packages/mek_data_class): Generate `hashCode`, `==`, `toString`, `copyWith` and `change` methods with low code.
