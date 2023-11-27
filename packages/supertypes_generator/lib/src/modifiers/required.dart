import 'package:supertypes_generator/generator.dart';
import 'package:supertypes_generator/src/field_definition.dart';
import 'package:supertypes_generator/src/super_type_definition.dart';

void applyRequired(
  FieldDefinition field,
  SuperTypeDefinition definition,
) {
  final children = field.children;
  if (children == null) {
    final def = generate(field.type, definition);
    for (final child in def.fields.toList()) {
      child.nullabilityOverride = false;
    }
    return;
  }

  for (final child in children) {
    applyRequired(child, definition);
  }
}
