// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

part of 'note.dart';

// **************************************************************************
// SuperTypesGenerator
// **************************************************************************

/// Generate for [$User]
typedef User = ({
  String email,
  int id,
  String name,
  Role? role,
});

User UserFromJson(Map<String, dynamic> json) {
  return (
    email: json['email'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    role: json['role'] == null
        ? null
        : Role.values.firstWhere((e) => e.name == json['role']),
  );
}

extension UserJson on User {
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
      'name': name,
      'role': role?.name,
    };
  }
}

/// Generate for [$Note]
typedef Note = ({
  String content,
  DateTime createdAt,
  int id,
  String title,
  DateTime updatedAt,
  ({
    String email,
    int id,
    String name,
    Role? role,
  })? user,
});

Note NoteFromJson(Map<String, dynamic> json) {
  return (
    content: json['content'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    id: json['id'] as int,
    title: json['title'] as String,
    updatedAt: DateTime.parse(json['updatedAt'] as String),
    user: (
      email: json['email'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      role: json['role'] == null
          ? null
          : Role.values.firstWhere((e) => e.name == json['role']),
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
