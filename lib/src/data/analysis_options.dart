import 'package:json_annotation/json_annotation.dart';

part 'analysis_options.g.dart';

@JsonSerializable()
class AnalysisOptions {
  final FormatterOptions formatter;

  const AnalysisOptions({this.formatter = const FormatterOptions()});

  factory AnalysisOptions.fromJson(Map<dynamic, dynamic> map) => _$AnalysisOptionsFromJson(map);
}

@JsonSerializable()
class FormatterOptions {
  final int pageWidth;

  const FormatterOptions({this.pageWidth = 80});

  factory FormatterOptions.fromJson(Map<dynamic, dynamic> map) => _$FormatterOptionsFromJson(map);
}
