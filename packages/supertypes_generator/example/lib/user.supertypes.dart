// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

part of 'user.dart';

// **************************************************************************
// SuperTypesGenerator
// **************************************************************************

/// Generate for [$User]
typedef User = ({
  DateTime createdAt,
  String email,
  int id,
  String name,
  String password,
  DateTime updatedAt,
});

User UserFromJson(Map<String, dynamic> json) {
  return (
    createdAt: DateTime.parse(json['created_at'] as String),
    email: json['email'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    password: json['password'] as String,
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}

extension UserJson on User {
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'email': email,
      'id': id,
      'name': name,
      'password': password,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// Generate for [$UserWithoutPassword]
typedef UserWithoutPassword = ({
  DateTime createdAt,
  String email,
  int id,
  String name,
  DateTime updatedAt,
});

UserWithoutPassword UserWithoutPasswordFromJson(Map<String, dynamic> json) {
  return (
    createdAt: DateTime.parse(json['created_at'] as String),
    email: json['email'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}

extension UserWithoutPasswordJson on UserWithoutPassword {
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'email': email,
      'id': id,
      'name': name,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

/// Generate for [$CreateUser]
typedef CreateUser = ({
  String email,
  String name,
  String password,
});

CreateUser CreateUserFromJson(Map<String, dynamic> json) {
  return (
    email: json['email'] as String,
    name: json['name'] as String,
    password: json['password'] as String,
  );
}

extension CreateUserJson on CreateUser {
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password,
    };
  }
}

/// Generate for [$UserWithTokens]
typedef UserWithTokens = ({
  DateTime createdAt,
  String email,
  int id,
  String name,
  DateTime updatedAt,
  String accessToken,
  String refreshToken,
});

UserWithTokens UserWithTokensFromJson(Map<String, dynamic> json) {
  return (
    createdAt: DateTime.parse(json['created_at'] as String),
    email: json['email'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    updatedAt: DateTime.parse(json['updated_at'] as String),
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );
}

extension UserWithTokensJson on UserWithTokens {
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'email': email,
      'id': id,
      'name': name,
      'updated_at': updatedAt.toIso8601String(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

/// Generate for [$Tokens]
typedef Tokens = ({
  String accessToken,
  String refreshToken,
});

Tokens TokensFromJson(Map<String, dynamic> json) {
  return (
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );
}

extension TokensJson on Tokens {
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
