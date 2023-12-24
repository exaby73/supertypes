import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:supertypes/supertypes.dart';
import 'package:supertypes_generator/src/checkers.dart';
import 'package:supertypes_generator/src/field_definition.dart';
import 'package:supertypes_generator/src/modifiers/merge.dart';
import 'package:supertypes_generator/src/modifiers/omit.dart';
import 'package:supertypes_generator/src/modifiers/partial.dart';
import 'package:supertypes_generator/src/modifiers/pick.dart';
import 'package:supertypes_generator/src/modifiers/required.dart';
import 'package:supertypes_generator/src/modifiers/with_partial.dart';
import 'package:supertypes_generator/src/modifiers/with_required.dart';
import 'package:supertypes_generator/src/super_type_definition.dart';
import 'package:supertypes_generator/src/utils/records.dart';

class SuperTypesGenerator extends GeneratorForAnnotation<SuperType> {
  SuperTypesGenerator();

  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    try {
      if (element is! TypeAliasElement) {
        throw InvalidGenerationSourceError(
          'The element annotated with @superType is not a type alias.',
          element: element,
        );
      }

      if (!element.name.startsWith(RegExp(r'^_?\$'))) {
        throw InvalidGenerationSourceError(
          'The element annotated with @superType must start with a \$.',
          element: element,
        );
      }

      final startBuffer = StringBuffer();
      startBuffer.write('/// Generate for [${element.name}]\n');
      final generatedName = element.name.replaceFirst('\$', '');
      startBuffer.write('typedef $generatedName = ');
      yield startBuffer.toString();

      final type = element.aliasedType;
      final def = generate(type);

      final jsonMapping = getJsonMapping(element);
      yield _generateFinalCode(
        def,
        name: generatedName,
        jsonMapping: jsonMapping,
      );
    } catch (e, s) {
      if (e is InvalidGenerationSourceError) rethrow;
      print('Error: $e');
      print('Stack: $s');
    }
  }
}

SuperTypeDefinition generate(
  DartType type, [
  SuperTypeDefinition? definition,
]) {
  final def = definition ?? SuperTypeDefinition();

  if (type is RecordType) {
    def.fields.addAll(getFieldDefinitionsFromRecord(type));
    return def;
  }

  if (type is! InterfaceType) return def;

  // This is used as a wrapper type
  final initialDefinition = FieldDefinition(
    type: type.typeArguments.first,
    restTypes: type.typeArguments.skip(1),
  );

  switch (type.element.name) {
    case 'Partial':
      applyPartial(initialDefinition, def);
    case 'Required':
      applyRequired(initialDefinition, def);
    case 'Omit':
      applyOmit(initialDefinition, def);
    case 'Pick':
      applyPick(initialDefinition, def);
    case 'Merge':
      applyMerge(initialDefinition, def);
    case 'WithPartial':
      applyWithPartial(initialDefinition, def);
    case 'WithRequired':
      applyWithRequired(initialDefinition, def);
    default:
    // Generic class handling
  }

  return def;
}

String _generateFinalCode(
  SuperTypeDefinition def, {
  required String name,
  required Map<String, String>? jsonMapping,
}) {
  final hasJson = jsonMapping != null;
  final buffer = StringBuffer();
  final SuperTypeDefinition(:positionalFields, :namedFields) = def;

  buffer.write('(');

  for (final field in positionalFields) {
    buffer.write('${field.generateCode()},');
  }

  if (namedFields.isNotEmpty) {
    buffer.write('{');
    for (final field in namedFields) {
      buffer.write('${field.generateCode()},');
    }
    buffer.write('}');
  }

  buffer.write(');');

  if (namedFields.isNotEmpty && hasJson) {
    // fromJson starts

    buffer.write('\n\n');

    buffer.writeln(
      '$name ${name}FromJson(Map<String, dynamic> json) {',
    );

    buffer.writeln('return (');

    for (final field in namedFields) {
      buffer.writeln(
        field.generateFromJsonForNamedFields(jsonMapping[field.name]),
      );
    }

    buffer.writeln(');');

    buffer.write('}');

    // toJson starts

    buffer.write('\n');
    buffer.writeln('extension ${name}Json on $name {');

    buffer.writeln('Map<String, dynamic> toJson() {\nreturn {');

    for (final field in namedFields) {
      buffer.writeln(
        field.generateToJsonForNamedFields(jsonMapping[field.name]),
      );
    }

    buffer.writeln('};\n}\n}');
  }

  return buffer.toString();
}
