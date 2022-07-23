// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_group_node.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

// ignore_for_file: annotate_overrides

mixin _$Node {
  Node get _self => this as Node;

  Iterable<Object?> get _props sync* {
    yield _self.dirName;
    yield _self.files;
    yield _self.children;
  }

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _$Node &&
          runtimeType == other.runtimeType &&
          DataClass.$equals(_props, other._props);

  int get hashCode => Object.hashAll(_props);

  String toString() => (ClassToString('Node')
        ..add('dirName', _self.dirName)
        ..add('files', _self.files)
        ..add('children', _self.children))
      .toString();
}
