import 'package:analyzer/dart/element/type.dart';
import 'package:supertypes_generator/generator.dart';
import 'package:supertypes_generator/src/field_definition.dart';
import 'package:supertypes_generator/src/super_type_definition.dart';

void applyPick(
  FieldDefinition field,
  SuperTypeDefinition definition,
) {
  final children = field.children;
  final picks = field.restTypes!.first as RecordType;

  if (children == null) {
    final def = generate(field.type, definition);

    final positionalFields = def.positionalFields.toList();
    for (int i = 0; i < positionalFields.length; i++) {
      if (picks.positionalFields.length <= i) {
        break;
      }

      final pickField = picks.positionalFields[i];
      if (pickField.type.element?.name == 'Required') {
        positionalFields[i].isNullable = false;
      } else if (pickField.type.element?.name == 'Partial') {
        positionalFields[i].isNullable = true;
      } else if (pickField.type.element?.name != 'Pick') {
        def.fields.removeAt(i);
      }
    }

    final namedFields = def.namedFields.toList();
    for (int i = 0; i < namedFields.length; i++) {
      final pickIndex = picks.namedFields.indexWhere(
        (element) => element.name == namedFields[i].name,
      );

      if (pickIndex == -1 ||
          _shouldRemove(
            namedFields[i],
            picks.namedFields[pickIndex],
          )) {
        def.fields.removeAt(
          def.fields.indexWhere(
            (element) => element.name == namedFields[i].name,
          ),
        );
      } else if (_shouldPickRequired(
        namedFields[i],
        picks.namedFields[pickIndex],
      )) {
        namedFields[i].isNullable = false;
      } else if (_shouldPickPartial(
        namedFields[i],
        picks.namedFields[pickIndex],
      )) {
        namedFields[i].isNullable = true;
      }
    }

    return;
  }

  for (final child in children) {
    applyPick(child, definition);
  }
}

bool _shouldRemove(
  FieldDefinition namedField,
  RecordTypeNamedField pickField,
) {
  final name = pickField.type.element?.name;
  if (name == 'Required' || name == 'Partial') {
    return false;
  }
  return namedField.name == pickField.name && name != 'Pick';
}

bool _shouldPickRequired(
  FieldDefinition namedField,
  RecordTypeNamedField pickField,
) {
  return namedField.name == pickField.name &&
      pickField.type.element?.name == 'Required';
}

bool _shouldPickPartial(
  FieldDefinition namedField,
  RecordTypeNamedField pickField,
) {
  return namedField.name == pickField.name &&
      pickField.type.element?.name == 'Partial';
}
