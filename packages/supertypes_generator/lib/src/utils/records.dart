import 'package:analyzer/dart/element/nullability_suffix.dart';
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
    if (type.isDartCoreRecord) {
      yield FieldDefinition(
        type: type,
        isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
        children: getFieldDefinitionsFromRecord(
          type as RecordType,
          definition,
        ),
      );
    } else if (!isCoreType(type) && type is InterfaceType) {
      yield FieldDefinition(
        type: type,
        isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
        children: generate(type, definition).fields,
      );
    } else {
      yield FieldDefinition(
        type: type,
        isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
      );
    }
  }

  for (final param in record.namedFields) {
    final type = param.type;
    if (type.isDartCoreRecord) {
      yield FieldDefinition(
        name: param.name,
        type: type,
        isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
        children: getFieldDefinitionsFromRecord(
          type as RecordType,
          definition,
        ),
      );
    } else if (!isCoreType(type) && type is InterfaceType) {
      yield FieldDefinition(
        name: param.name,
        type: type,
        isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
        children: generate(type, definition).fields,
      );
    } else {
      yield FieldDefinition(
        name: param.name,
        type: type,
        isNullable: type.nullabilitySuffix == NullabilitySuffix.question,
      );
    }
  }
}
