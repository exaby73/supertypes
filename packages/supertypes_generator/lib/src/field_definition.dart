import 'package:analyzer/dart/element/type.dart';

class FieldDefinition {
  String? name;
  DartType type;
  bool isNullable;

  Iterable<FieldDefinition>? children;

  FieldDefinition({
    this.name,
    required this.type,
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
}
