import 'package:barrel_files_annotation/barrel_files_annotation.dart';

@includeInBarrelFile
class SuperType {
  final bool fromJson;

  const SuperType({this.fromJson = false});
}

@includeInBarrelFile
const superType = SuperType();

@includeInBarrelFile
const superTypeWithJson = SuperType(fromJson: true);
