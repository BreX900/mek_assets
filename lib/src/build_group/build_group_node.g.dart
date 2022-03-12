// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_group_node.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$Node {
  Node get _self => this as Node;

  List<Object?> get _props => [
        _self.dirName,
        _self.filePaths,
        _self.children,
      ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Node &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  String toString() => (ClassToString('Node')
        ..add('dirName', _self.dirName)
        ..add('filePaths', _self.filePaths)
        ..add('children', _self.children))
      .toString();
}
