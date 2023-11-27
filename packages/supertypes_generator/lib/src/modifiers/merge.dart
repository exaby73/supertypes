import 'package:analyzer/dart/element/type.dart';
import 'package:supertypes_generator/generator.dart';
import 'package:supertypes_generator/src/field_definition.dart';
import 'package:supertypes_generator/src/super_type_definition.dart';

void applyMerge(
  FieldDefinition field,
  SuperTypeDefinition definition,
) {
  final children = field.children;
  final mergeRight = field.restTypes!.first as RecordType;

  if (children == null) {
    final def = generate(field.type, definition);

    final mergeRightPositional = mergeRight.positionalFields.toList();

    for (int i = 0; i < mergeRightPositional.length; i++) {
      def.fields.add(
        FieldDefinition(
          type: mergeRightPositional[i].type,
        ),
      );
    }
    final mergeRightNamed = mergeRight.namedFields.toList();

    for (int i = 0; i < mergeRightNamed.length; i++) {
      final rightElement = mergeRightNamed[i];
      final index = def.fields.indexWhere(
        (element) => element.name == rightElement.name,
      );
      final fieldDefinition = FieldDefinition(
        name: rightElement.name,
        type: rightElement.type,
      );
      if (index == -1) {
        def.fields.add(fieldDefinition);
      } else {
        def.fields[index] = fieldDefinition;
      }
    }

    return;
  }

  for (final child in children) {
    applyMerge(child, definition);
  }
}
