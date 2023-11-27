import 'package:analyzer/dart/element/type.dart';
import 'package:supertypes_generator/generator.dart';
import 'package:supertypes_generator/src/field_definition.dart';
import 'package:supertypes_generator/src/super_type_definition.dart';

void applyOmit(
  FieldDefinition field,
  SuperTypeDefinition definition,
) {
  final children = field.children;

  final omits = field.restTypes!.first as RecordType;

  if (children == null) {
    final def = generate(field.type, definition);

    final positionalFields = def.positionalFields.toList();
    for (int i = 0; i < omits.positionalFields.length; i++) {
      if (positionalFields.length <= i) {
        break;
      }
      final omitField = omits.positionalFields[i];
      if (omitField.type.element?.name == 'Omit') {
        def.fields.removeAt(i);
      }
    }

    final namedFields = def.namedFields.toList();
    for (int i = 0; i < omits.namedFields.length; i++) {
      if (namedFields.length <= i) {
        break;
      }
      final omitField = omits.namedFields[i];
      if (omitField.type.element?.name == 'Omit') {
        final index =
            def.fields.indexWhere((element) => element.name == omitField.name);
        if (index != -1) continue;
        def.fields.removeAt(index);
      }
    }

    return;
  }

  for (final child in children) {
    applyOmit(child, definition);
  }
}
