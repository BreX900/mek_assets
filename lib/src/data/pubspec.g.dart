// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_cast

part of 'pubspec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pubspec _$PubspecFromJson(Map json) => $checkedCreate('Pubspec', json, ($checkedConvert) {
  final val = Pubspec(
    environment: $checkedConvert('environment', (v) => PubspecEnvironment.fromJson(v as Map)),
    flutter: $checkedConvert('flutter', (v) => Flutter.fromJson(v as Map)),
    mekAssets: $checkedConvert(
      'mek_assets',
      (v) => v == null ? null : MekAssetsConfig.fromJson(v as Map),
    ),
  );
  return val;
}, fieldKeyMap: const {'mekAssets': 'mek_assets'});

PubspecEnvironment _$PubspecEnvironmentFromJson(Map json) =>
    $checkedCreate('PubspecEnvironment', json, ($checkedConvert) {
      final val = PubspecEnvironment(
        sdk: $checkedConvert('sdk', (v) => PubspecEnvironment._parseVersion(v as String)),
      );
      return val;
    });

Flutter _$FlutterFromJson(Map json) => $checkedCreate('Flutter', json, ($checkedConvert) {
  final val = Flutter(
    assets: $checkedConvert(
      'assets',
      (v) => (v as List<dynamic>?)?.map(FlutterAsset.fromJson).toList() ?? const <FlutterAsset>[],
    ),
  );
  return val;
});

FlutterAsset _$FlutterAssetFromJson(Map json) =>
    $checkedCreate('FlutterAsset', json, ($checkedConvert) {
      final val = FlutterAsset(path: $checkedConvert('path', (v) => v as String));
      return val;
    });
