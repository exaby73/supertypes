import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:supertypes_generator/generator.dart';

Builder supertypesBuilder(BuilderOptions options) {
  return PartBuilder([SuperTypesGenerator()], '.supertypes.dart');
}
