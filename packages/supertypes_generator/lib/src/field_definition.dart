import 'package:analyzer/dart/element/type.dart';
import 'package:supertypes_generator/src/utils/records.dart';

class FieldDefinition {
  String? name;
  DartType type;
  Iterable<DartType>? restTypes;
  bool isNullable;

  Iterable<FieldDefinition>? children;

  FieldDefinition({
    this.name,
    required this.type,
    this.restTypes,
    required this.isNullable,
    this.children,
  });

  bool get isPositional => name == null;

  String generate() {
    if (children == null) {
      final nullSuffix = isNullable ? '?' : '';
      final type =
          '${this.type.getDisplayString(withNullability: false)}$nullSuffix';
      return isPositional ? type : '$type $name';
    }

    final buffer = StringBuffer();
    buffer.write('(');
    final positional = children!.where((f) => f.isPositional);
    final named = children!.where((f) => !f.isPositional);
    for (final child in positional) {
      buffer.write(child.generate());
      buffer.write(', ');
    }
    if (named.isNotEmpty) {
      buffer.write('{');
      for (final child in named) {
        buffer.write(child.generate());
        buffer.write(', ');
      }
      buffer.write('}');
    }
    buffer.write(')');

    if (isNullable) {
      buffer.write('?');
    }

    return isPositional ? buffer.toString() : '$buffer $name';
  }

  String generateToJsonForNamedFields(String? jsonMappedName) {
    assert(name != null, 'This field is not a named field');
    final buffer = StringBuffer();
    buffer.write("'${jsonMappedName ?? name}': ");
    if (children == null) {
      buffer.write('${_generateToJson(name!, type)},\n');
      return buffer.toString();
    }

    return buffer.toString();
  }

  String _generateToJson(String name, DartType type) {
    if (!isCoreType(type) || type is RecordType) {
      return '$name.toJson()';
    }
    if (type.getDisplayString(withNullability: false) == 'DateTime') {
      return '$name.toIso8601String()';
    }
    if (type.isDartCoreEnum) {
      return '$name.name';
    }
    return name;
  }
}
