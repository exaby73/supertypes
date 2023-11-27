// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// SuperTypesGenerator
// **************************************************************************

/// Generate for [$Note]
typedef Note = ({
  String content,
  DateTime createdAt,
  int id,
  String title,
  DateTime updatedAt,
  ({String email, int id, String name, String password}) user,
});

extension NoteJson on Note {
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'id': id,
      'title': title,
      'updated_at': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

/// Generate for [$User]
typedef User = ({
  String email,
  int id,
  String name,
  String password,
});

extension UserJson on User {
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
      'name': name,
      'password': password,
    };
  }
}

/// Generate for [$UpdateNoteDto]
typedef UpdateNoteDto = ({
  String? content,
  String? title,
});

extension UpdateNoteDtoJson on UpdateNoteDto {
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'title': title,
    };
  }
}
