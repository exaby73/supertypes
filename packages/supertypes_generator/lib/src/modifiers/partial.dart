import 'package:supertypes_generator/generator.dart';
import 'package:supertypes_generator/src/field_definition.dart';
import 'package:supertypes_generator/src/super_type_definition.dart';

void applyPartial(
  FieldDefinition field,
  SuperTypeDefinition definition,
) {
  final children = field.children;
  if (children == null) {
    final def = generate(field.type, definition);
    for (final child in def.fields.toList()) {
      child.isNullable = true;
    }
    return;
  }

  for (final child in children) {
    applyPartial(child, definition);
  }
}
