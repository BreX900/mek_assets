// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: cast_nullable_to_non_nullable, unnecessary_cast

part of 'analysis_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalysisOptions _$AnalysisOptionsFromJson(Map json) =>
    $checkedCreate('AnalysisOptions', json, ($checkedConvert) {
      final val = AnalysisOptions(
        formatter: $checkedConvert(
          'formatter',
          (v) => v == null
              ? const FormatterOptions()
              : FormatterOptions.fromJson(v as Map),
        ),
      );
      return val;
    });

FormatterOptions _$FormatterOptionsFromJson(Map json) =>
    $checkedCreate('FormatterOptions', json, ($checkedConvert) {
      final val = FormatterOptions(
        pageWidth: $checkedConvert(
          'page_width',
          (v) => (v as num?)?.toInt() ?? 80,
        ),
      );
      return val;
    }, fieldKeyMap: const {'pageWidth': 'page_width'});
