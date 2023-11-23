import 'package:supertypes/supertypes.dart';

part 'note.supertypes.dart';

typedef Note = ({
  int id,
  String title,
  String content,
  DateTime createdAt,
  DateTime updatedAt,
});

@superType
typedef $UpdateNoteDto = Merge<
    Omit<
        Partial<Note>,
        ({
          Omit createdAt,
          Omit updatedAt,
        })>,
    ({
      int id,
      double foo,
    })>;
