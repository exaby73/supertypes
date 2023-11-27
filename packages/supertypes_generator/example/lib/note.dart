import 'package:supertypes/supertypes.dart';

part 'note.supertypes.dart';

enum Role {
  admin,
  user,
}

@superTypeWithJson
typedef $User = ({
  int id,
  String name,
  String email,
  Role? role,
});

@SuperType(
  jsonMapping: {
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
)
typedef $Note = ({
  int id,
  String title,
  String content,
  DateTime createdAt,
  DateTime updatedAt,
  $User? user,
});
