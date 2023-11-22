import 'package:supertypes/supertypes.dart';

part 'note.supertypes.dart';

typedef User = ({
  int id,
  String name,
  String email,
  DateTime createdAt,
  DateTime updatedAt,
});

typedef Note = ({
  int id,
  String title,
  String content,
  User user,
  DateTime createdAt,
  DateTime updatedAt,
});

@superType
typedef $UpdateNoteDto = Partial<Note>;
