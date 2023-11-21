import 'package:supertypes_generator/src/field_definition.dart';

class SuperTypeDefinition {
  final List<FieldDefinition> fields = [];

  SuperTypeDefinition();

  Iterable<FieldDefinition> get positionalFields =>
      fields.where((f) => f.isPositional);

  Iterable<FieldDefinition> get namedFields =>
      fields.where((f) => !f.isPositional);
}
