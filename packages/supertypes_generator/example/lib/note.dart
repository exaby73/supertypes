import 'package:supertypes/supertypes.dart';

part 'note.supertypes.dart';

@superTypeWithJson
typedef $Foo = ({String foo});

@superTypeWithJson
typedef $Bar = ({int bar, $Foo foo});

@superTypeWithJson
typedef $Note = ({
  int id,
  String title,
  String content,
  List<$Bar> statuses,
  DateTime createdAt,
});

@superTypeWithJson
typedef $NewNote = Pick<$Note, ({Pick title, Pick content})>;

@superTypeWithJson
typedef $UpdateNote
    = Omit<WithRequired<Partial<$Note>, ({Required id})>, ({Omit createdAt})>;
