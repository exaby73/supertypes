import 'package:supertypes/supertypes.dart';

part 'note.supertypes.dart';

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
  $User user,
  DateTime createdAt,
  DateTime updatedAt,
});

@superTypeWithJson
typedef $User = ({
  int id,
  String name,
  String email,
  String password,
});

@superTypeWithJson
typedef $UpdateNoteDto = Pick<$Note, ({Partial title, Partial content})>;
