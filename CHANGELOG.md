## 2.0.0+1
- docs: fixed example documentation

## 2.0.0
- feat!: automatically generate Dart classes with resources based on Flutter `assets` property
- build: require dart `3.5`

## 1.1.1
- fix: fixes regexp for windows system

## 1.1.0
- feat: Can exclude files and folders from generation, pass the `exclude` option
- feat: Can generate map files, pass the `create_map_files` option to `true`

## 1.0.0
- feat: stable release
- fix: typo in README.md
- fix: outputs of paths/fields is not sorted

## 0.1.1
- Fix incorrect multi format output

## 0.1.0
- Fix incorrect `format` mapping for format file
- Fix generation of fields names on single format file
- Feat added `multi` format, it generates one class for directory
- Feat added `prefix_class_name` field in group to customize class name generation in `multi` format
- Feat added `output_file_name` field in group to customize generated output file name
BREAKING CHANGES:
    - Changed defaults value for output file name and class name
    - Renamed `multi` format to `tree` format

## 0.0.1

- Initial version.
