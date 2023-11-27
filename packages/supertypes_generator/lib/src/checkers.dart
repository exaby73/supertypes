import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:supertypes/supertypes.dart';

const superTypeChecker = TypeChecker.fromRuntime(SuperType);

Map<String, String>? getJsonMapping(Element element) {
  final annotation = superTypeChecker.firstAnnotationOf(element);
  if (annotation == null) return null;
  final hasFromJson = annotation.getField('_fromJson')!.toBoolValue()!;
  if (!hasFromJson) return null;
  final jsonMapping = annotation.getField('jsonMapping')!.toMapValue();
  return jsonMapping?.map(
        (key, value) => MapEntry(
          key!.toStringValue()!,
          value!.toStringValue()!,
        ),
      ) ??
      {};
}
