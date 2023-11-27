import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:supertypes_generator/src/utils/records.dart';

class FieldDefinition {
  String? name;
  DartType type;
  Iterable<DartType>? restTypes;
  bool? nullabilityOverride;

  Iterable<FieldDefinition>? children;

  FieldDefinition({
    this.name,
    required this.type,
    this.nullabilityOverride,
    this.restTypes,
    this.children,
  });

  bool get isPositional => name == null;

  bool get isNullable =>
      nullabilityOverride ??
      type.nullabilitySuffix == NullabilitySuffix.question;

  String generate() {
    if (children == null) {
      final nullSuffix = isNullable ? '?' : '';
      final typeString =
          '${type.getDisplayString(withNullability: false)}$nullSuffix';
      return isPositional ? typeString : '$typeString $name';
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
    buffer.write('${_generateToJson(name!, type)},\n');
    return buffer.toString();
  }

  String _generateToJson(String name, DartType type) {
    final nullSuffix = isNullable ? '?' : '';

    if (type.element is EnumElement) {
      return '$name$nullSuffix.name';
    }

    if (!isCoreType(type) || type is RecordType) {
      return '$name$nullSuffix.toJson()';
    }

    if (type.getDisplayString(withNullability: false) == 'DateTime') {
      return '$name$nullSuffix.toIso8601String()';
    }

    return name;
  }

  String generateFromJsonForNamedFields(
    String? jsonMappedName, [
    List<String> jsonKeys = const [],
  ]) {
    assert(name != null, 'This field is not a named field');
    final buffer = StringBuffer();

    if (children == null) {
      buffer.write("$name: ${_generateFromJson(name!, type, jsonKeys)},\n");
      return buffer.toString();
    }

    buffer.write("$name: (");
    for (final child in children!) {
      buffer.write(
        child.generateFromJsonForNamedFields(jsonMappedName),
      );
    }
    buffer.write("),\n");

    return buffer.toString();
  }

  String _generateFromJson(String name, DartType type, List<String> jsonKeys) {
    final nullSuffix = isNullable ? '?' : '';
    final nestedJson = jsonKeys.map((e) => "['$e']").join();
    final jsonAccessor = "json$nestedJson['$name']";

    if (type is RecordType) {
      final buffer = StringBuffer();
      final fields = getFieldDefinitionsFromRecord(type);
      if (isNullable) {
        buffer.write("$jsonAccessor == null ? null : ");
      }
      buffer.write('(');
      for (final field in fields) {
        buffer.writeln(
          field.generateFromJsonForNamedFields(
            name,
            [
              ...jsonKeys,
              name,
            ],
          ),
        );
      }
      buffer.write(')');
      return buffer.toString();
    }

    if (type.element is EnumElement) {
      if (isNullable) {
        return "$jsonAccessor == null ? null : "
            "${type.getDisplayString(withNullability: false)}.values.firstWhere((e) => "
            "e.name == $jsonAccessor)";
      }
      return "${type.getDisplayString(withNullability: false)}.values.firstWhere((e) => "
          "e.name == $jsonAccessor)";
    }

    if (type.getDisplayString(withNullability: false) == 'DateTime') {
      if (isNullable) {
        return "$jsonAccessor == null ? null : DateTime.parse($jsonAccessor as String)";
      } else {
        return "DateTime.parse($jsonAccessor as String)";
      }
    }

    return "$jsonAccessor as ${type.getDisplayString(withNullability: false)}$nullSuffix";
  }
}
