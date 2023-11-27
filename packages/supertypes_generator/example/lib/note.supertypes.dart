// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

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
  ({
    Partial<({int bar, String foo})> baz,
    String email,
    int id,
    String name,
    Role role
  })? user,
});

Note NoteFromJson(Map<String, dynamic> json) {
  return (
    content: json['content'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    id: json['id'] as int,
    title: json['title'] as String,
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    user: json['user'] == null
        ? null
        : (
            email: json['user']['email'] as String,
            id: json['user']['id'] as int,
            name: json['user']['name'] as String,
            role: Role.values.firstWhere((e) => e.name == json['user']['role']),
          ),
  );
}

extension NoteJson on Note {
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'id': id,
      'title': title,
      'updated_at': updatedAt.toIso8601String(),
      'user': user?.toJson(),
    };
  }
}

/// Generate for [$User]
typedef User = ({
  ({
    int? bar,
    String? foo,
  })? baz,
  String email,
  int id,
  String name,
  Role role,
});

User UserFromJson(Map<String, dynamic> json) {
  return (
    email: json['email'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    role: Role.values.firstWhere((e) => e.name == json['role']),
  );
}

extension UserJson on User {
  Map<String, dynamic> toJson() {
    return {
      'baz': baz?.toJson(),
      'email': email,
      'id': id,
      'name': name,
      'role': role.name,
    };
  }
}
