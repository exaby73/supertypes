import 'package:analyzer/dart/element/type.dart';
import 'package:supertypes_generator/generator.dart';
import 'package:supertypes_generator/src/field_definition.dart';
import 'package:supertypes_generator/src/super_type_definition.dart';

void applyWithRequired(
  FieldDefinition field,
  SuperTypeDefinition definition,
) {
  final children = field.children;
  final required = field.restTypes!.first as RecordType;

  if (children == null) {
    final def = generate(field.type, definition);

    final positionalFields = def.positionalFields.toList();
    for (int i = 0; i < positionalFields.length; i++) {
      if (i >= required.positionalFields.length) {
        break;
      }

      final child = positionalFields[i];
      if (required.positionalFields[i].type.element?.name == 'Required') {
        child.nullabilityOverride = false;
      }
    }

    final namedFields = def.namedFields.toList();
    for (int i = 0; i < namedFields.length; i++) {
      final child = namedFields[i];
      final requiredIndex = required.namedFields.indexWhere(
        (element) => element.name == child.name,
      );
      if (requiredIndex == -1) {
        continue;
      }

      if (required.namedFields[requiredIndex].type.element?.name ==
              'Required' &&
          required.namedFields[requiredIndex].name == child.name) {
        child.nullabilityOverride = false;
      }
    }

    return;
  }

  for (final child in children) {
    applyWithRequired(child, definition);
  }
}
