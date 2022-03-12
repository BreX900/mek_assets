// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_multi_class_group.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$_Node {
  _Node get _self => this as _Node;

  List<Object?> get _props => [
        _self.dirName,
        _self.filePaths,
        _self.children,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$_Node &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  String toString() => (ClassToString('_Node')
        ..add('dirName', _self.dirName)
        ..add('filePaths', _self.filePaths)
        ..add('children', _self.children))
      .toString();
}
