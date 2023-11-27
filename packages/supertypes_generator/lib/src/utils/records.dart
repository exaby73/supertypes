import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:supertypes_generator/generator.dart';
import 'package:supertypes_generator/src/field_definition.dart';
import 'package:supertypes_generator/src/super_type_definition.dart';

bool isCoreType(DartType type) {
  final element = type.element;
  if (element == null) return false;
  final uri = element.librarySource?.uri;
  if (uri == null) return false;
  return uri.toString() == 'dart:core';
}

Iterable<FieldDefinition> getFieldDefinitionsFromRecord(
  RecordType record, [
  SuperTypeDefinition? definition,
]) sync* {
  for (final param in record.positionalFields) {
    final type = param.type;
    if (type is RecordType) {
      yield FieldDefinition(
        type: type,
        children: getFieldDefinitionsFromRecord(
          type,
          definition,
        ),
      );
    } else if (!isCoreType(type) && type is InterfaceType) {
      yield FieldDefinition(
        type: type,
        children: generate(type, definition).fields,
      );
    } else {
      yield FieldDefinition(type: type);
    }
  }

  for (final param in record.namedFields) {
    final type = param.type;
    if (type is RecordType) {
      yield FieldDefinition(
        name: param.name,
        type: type,
        children: getFieldDefinitionsFromRecord(
          type,
          definition,
        ),
      );
    } else if (!isCoreType(type) &&
        type is InterfaceType &&
        type.element is! EnumElement) {
      yield FieldDefinition(
        name: param.name,
        type: type,
        children: generate(type, definition).fields,
      );
    } else {
      yield FieldDefinition(
        name: param.name,
        type: type,
      );
    }
  }
}
