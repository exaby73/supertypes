import 'package:barrel_files_annotation/barrel_files_annotation.dart';

@includeInBarrelFile
class SuperType {
  final bool _fromJson;
  final Map<String, String>? jsonMapping;

  bool get fromJson => _fromJson;

  const SuperType({
    bool fromJson = false,
    this.jsonMapping,
  }) : _fromJson = fromJson || jsonMapping != null;
}

@includeInBarrelFile
const superType = SuperType();

@includeInBarrelFile
const superTypeWithJson = SuperType(fromJson: true);
