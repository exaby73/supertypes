import 'package:analyzer/dart/element/type.dart';
import 'package:supertypes_generator/generator.dart';
import 'package:supertypes_generator/src/field_definition.dart';
import 'package:supertypes_generator/src/super_type_definition.dart';

void applyWithPartial(
  FieldDefinition field,
  SuperTypeDefinition definition,
) {
  final children = field.children;
  final partial = field.restTypes!.first as RecordType;

  if (children == null) {
    final def = generate(field.type, definition);
    
    final positionalFields = def.positionalFields.toList();
    for (int i = 0; i < positionalFields.length; i++) {
      if (i >= partial.positionalFields.length) {
        break;
      }

      final child = positionalFields[i];
      if (partial.positionalFields[i].type.element?.name == 'Partial') {
        child.isNullable = true;
      }
    }

    final namedFields = def.namedFields.toList();
    for (int i = 0; i < namedFields.length; i++) {
      final child = namedFields[i];
      final partialIndex = partial.namedFields.indexWhere(
        (element) => element.name == child.name,
      );
      if (partialIndex == -1) {
        continue;
      }
      
      if (partial.namedFields[partialIndex].type.element?.name == 'Partial' &&
          partial.namedFields[partialIndex].name == child.name) {
        child.isNullable = true;
      }
    }

    return;
  }

  for (final child in children) {
    applyWithPartial(child, definition);
  }
}
