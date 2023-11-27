import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:supertypes_generator/generator.dart';

Builder supertypesBuilder(BuilderOptions options) {
  return PartBuilder(
    [SuperTypesGenerator()],
    '.supertypes.dart',
    header: '// GENERATED CODE - DO NOT MODIFY BY HAND\n'
        '// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls',
  );
}
